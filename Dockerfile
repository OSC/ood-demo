# =========================
# Stage 1: base (OOD + Lmod)
# =========================
FROM rockylinux/rockylinux:9 AS base
LABEL maintainer="tdockendorf@osc.edu; johrstrom@osc.edu"

RUN dnf install -y https://yum.osc.edu/ondemand/4.0/ondemand-release-web-4.0-1.el9.noarch.rpm && \
    dnf -y update && \
    dnf install -y dnf-utils && \
    dnf config-manager --set-enabled crb && \
    dnf -y module enable nodejs:20 ruby:3.3 && \
    dnf install -y epel-release && \
    dnf install -y procps libffi-devel python3-devel gcc libstdc++ zlib openssl && \
    dnf install -y --nogpgcheck ondemand ondemand-dex && \
    dnf install -y Lmod && \
    dnf clean all && rm -rf /var/cache/dnf/*

# Patch OOD’s httpd config
RUN sed -i 's|--rpm|--rpm -f --insecure|g' /etc/systemd/system/httpd.service.d/ood-portal.conf && \
    systemctl enable httpd ondemand-dex

# Create dev user
RUN useradd jesse && chmod 600 /etc/shadow && \
    echo 'jesse:password' | chpasswd

# =========================
# Stage 2: wheels (cached Python deps)
# =========================
FROM rockylinux/rockylinux:9 AS builder
RUN dnf install -y python3 python3-pip gcc libffi-devel zlib-devel bzip2 bzip2-devel xz xz-devel
WORKDIR /wheels

RUN python3 -m pip install --upgrade pip wheel setuptools
RUN pip wheel jupyterlab==3.6.3 -w /wheels
RUN pip wheel jupyterlab==4.0.9 -w /wheels

# =========================
# Stage 3: apps layer
# =========================
FROM base AS apps

# Bring in built wheels
COPY --from=builder /wheels /tmp/wheels

# Install into isolated venvs using wheels (no re-download)
RUN python3 -m venv /opt/apps/jupyter/3.6.3 && \
    /opt/apps/jupyter/3.6.3/bin/pip install --no-index --find-links /tmp/wheels jupyterlab==3.6.3 && \
    python3 -m venv /opt/apps/jupyter/4.0.9 && \
    /opt/apps/jupyter/4.0.9/bin/pip install --no-index --find-links /tmp/wheels jupyterlab==4.0.9

# Modulefiles for Lmod
COPY files/modulefiles /opt/modulefiles

# Smoke test modules
RUN bash -lc 'module use /opt/modulefiles && \
    module load jupyter/3.6.3 && jupyter-lab --version && \
    module swap jupyter/4.0.9 && jupyter-lab --version'

# Generate spider JSON for OOD auto_modules
RUN bash -lc 'module use /opt/modulefiles && \
    tmp=$(mktemp) && \
    $LMOD_DIR/spider -o spider-json "$MODULEPATH" > "$tmp" && \
    mkdir -p /etc/ood/config/modules && \
    mv "$tmp" /etc/ood/config/modules/localhost.json && \
    chmod 644 /etc/ood/config/modules/localhost.json && \
    chmod 755 /etc/ood/config/modules'

# =========================
# Stage 4: final image (volatile files last)
# =========================
FROM apps

# Put frequently changed configs at the end so edits don’t bust cache
COPY files/ood_portal.yml /etc/ood/config/ood_portal.yml
COPY files/clusters.d /etc/ood/config/clusters.d
COPY files/apps /var/www/ood/apps/sys/
COPY files/config /etc/ood/config/apps/
COPY files/motd.md /etc/motd.md

CMD ["/sbin/init"]
