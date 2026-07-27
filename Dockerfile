FROM rockylinux/rockylinux:9
LABEL maintainer="tdockendorf@osc.edu; johrstrom@osc.edu"

RUN dnf install -y https://yum.osc.edu/ondemand/4.2/ondemand-release-web-4.2-1.el9.noarch.rpm && \
    dnf install -y https://yum.osc.edu/ondemand/4.2/ondemand-release-compute-4.2-1.el9.noarch.rpm && \
    dnf clean all && rm -rf /var/cache/dnf/*

# python3-devel resolves against a newer python3 than the first update leaves
# in place, so python3 is brought up to match before installing it.
RUN dnf -y update && \
    dnf install -y dnf-utils && \
    dnf config-manager --set-enabled crb && \
    dnf -y module enable nodejs:22 ruby:3.3 && \
    dnf install -y epel-release && \
    dnf -y update python3 python3-libs && \
    dnf install -y procps libffi-devel python3-devel gcc && \
    dnf install -y ondemand ondemand-dex && \
    dnf install -y xz libyaml-devel turbovnc python3-websockify && \
    dnf groupinstall -y "xfce" && \
    dnf clean all && rm -rf /var/cache/dnf/*

# Pinned because Rocky 9 ships Python 3.9 and newer releases of this stack
# require 3.10+, so an unpinned install silently stops working over time.
RUN pip3 install \
      jupyter==1.1.1 \
      jupyterlab==4.5.10 \
      notebook==7.5.7 \
      nbformat==5.10.4 \
      fastjsonschema==2.21.2

RUN sed -i 's|--rpm|--rpm -f --insecure|g' /etc/systemd/system/httpd.service.d/ood-portal.conf
RUN systemctl enable httpd ondemand-dex

# Mac's need this sed command
RUN sed -i 's#^CREATE_MAIL_SPOOL=yes#CREATE_MAIL_SPOOL=no#' /etc/default/useradd

RUN useradd jesse
RUN mkdir -p /var/www/ood/apps/dev/jesse && \
    ln -s /home/jesse/ondemand/dev /var/www/ood/apps/dev/jesse/gateway
RUN chmod 600 /etc/shadow

# switch to jesse to make ~/ondemand/dev
USER jesse
RUN mkdir -p /home/jesse/ondemand/dev

# Set up the Job Composer's database so the app is usable on first load.
# SECRET_KEY_BASE is only needed to boot Rails here; the PUN supplies its own at
# runtime. The checkpoint folds the schema out of the write-ahead log so the
# database file is self-contained in the image.
# Exec form so the shell is bash — `source` isn't available in Docker's default sh.
RUN ["/bin/bash", "-lc", "source /opt/ood/ondemand/enable && cd /var/www/ood/apps/sys/myjobs && SECRET_KEY_BASE=$(openssl rand -hex 32) RAILS_ENV=production bin/rake db:setup && python3 -c \"import sqlite3; sqlite3.connect('/home/jesse/ondemand/data/sys/myjobs/production.sqlite3').execute('PRAGMA wal_checkpoint(TRUNCATE)')\""]

# switch back to root to do everything else
USER root
RUN git clone https://github.com/OSC/bc_example_jupyter.git --bare /var/git/bc_example_jupyter
RUN chown jesse:jesse /var/git/bc_example_jupyter

COPY files/ood_portal.yml /etc/ood/config/ood_portal.yml
COPY files/clusters.d /etc/ood/config/clusters.d
COPY files/apps /var/www/ood/apps/sys/
COPY files/config /etc/ood/config/apps/
COPY files/motd.md /etc/motd.md
COPY files/nginx_stage.yml /etc/ood/config/nginx_stage.yml
COPY files/ondemand.d /etc/ood/config/ondemand.d

COPY files/apache/00-mutex.conf /etc/httpd/conf.d/00-mutex.conf
RUN mkdir -p /run/httpd

CMD [ "/sbin/init" ]
