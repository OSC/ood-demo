FROM rockylinux/rockylinux:9
LABEL maintainer="tdockendorf@osc.edu; johrstrom@osc.edu"

RUN dnf install -y https://yum.osc.edu/ondemand/4.2/ondemand-release-web-4.2-1.el9.noarch.rpm && \
    dnf install -y https://yum.osc.edu/ondemand/4.2/ondemand-release-compute-4.2-1.el9.noarch.rpm && \
    dnf clean all && rm -rf /var/cache/dnf/*

RUN dnf -y update && \
    dnf install -y dnf-utils && \
    dnf config-manager --set-enabled crb && \
    dnf -y module enable nodejs:22 ruby:3.3 && \
    dnf install -y epel-release && \
    dnf install -y procps libffi-devel python3-devel gcc && \
    dnf install -y ondemand ondemand-dex && \
    dnf install -y xz libyaml-devel turbovnc python3-websockify && \
    dnf groupinstall -y "xfce" && \
    dnf clean all && rm -rf /var/cache/dnf/*

# RUN pip3 install 'setuptools_scm<7' && \
RUN pip3 install jupyter

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

# switch back to root to do everything else
USER root
RUN git clone https://github.com/OSC/bc_example_jupyter.git --bare /var/git/bc_example_jupyter
RUN chown jesse:jesse /var/git/bc_example_jupyter

COPY files/ood_portal.yml /etc/ood/config/ood_portal.yml
COPY files/clusters.d /etc/ood/config/clusters.d
COPY files/apps /var/www/ood/apps/sys/
COPY files/config /etc/ood/config/apps/
COPY files/motd.md /etc/motd.md

COPY files/apache/00-mutex.conf /etc/httpd/conf.d/00-mutex.conf
RUN mkdir -p /run/httpd

CMD [ "/sbin/init" ]
