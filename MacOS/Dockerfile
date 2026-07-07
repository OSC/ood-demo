FROM openondemand/open-ondemand-demo:latest

# Add your new modifications below
COPY 00-mutex.conf /etc/httpd/conf.d/00-mutex.conf
COPY 10-create-run-httpd.conf /etc/systemd/system/httpd.service.d
