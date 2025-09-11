FROM rockylinux/rockylinux:9
LABEL maintainer="tdockendorf@osc.edu; johrstrom@osc.edu"

RUN dnf install -y https://yum.osc.edu/ondemand/4.0/ondemand-release-web-4.0-1.el9.noarch.rpm && \
    dnf clean all && rm -rf /var/cache/dnf/*

RUN dnf -y update && \
    dnf install -y dnf-utils && \
    dnf config-manager --set-enabled crb && \
    dnf -y module enable nodejs:20 ruby:3.3 && \
    dnf install -y epel-release && \
    dnf install -y procps libffi-devel python3-devel gcc && \
    dnf install -y ondemand ondemand-dex && \
    dnf clean all && rm -rf /var/cache/dnf/*

# RUN pip3 install 'setuptools_scm<7' && \
RUN pip3 install jupyter

RUN sed -i 's|--rpm|--rpm -f --insecure|g' /etc/systemd/system/httpd.service.d/ood-portal.conf
RUN systemctl enable httpd ondemand-dex

RUN useradd jesse
RUN chmod 600 /etc/shadow

COPY files/ood_portal.yml /etc/ood/config/ood_portal.yml
COPY files/clusters.d /etc/ood/config/clusters.d
COPY files/apps /var/www/ood/apps/sys/
COPY files/config /etc/ood/config/apps/
COPY files/motd.md /etc/motd.md

CMD [ "/sbin/init" ]