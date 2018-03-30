FROM registry.fedoraproject.org/fedora:27

ENV LANG C.UTF-8

RUN dnf -y update

RUN dnf -y install php-fpm php-ldap php-mbstring php-mcrypt php-PHPMailer sed

RUN sed -i -e 's/^pid =\(.*\)$/;pid =\1/g' -e 's/^daemonize =\(.*\)$/daemonize = no/g' -e 's/;systemd_interval =\(.*\)$/systemd_interval = 0/' /etc/php-fpm.conf
RUN sed -i -e 's/^listen =\(.*\)$/listen = 9090/g' -e 's/^listen.allowed_clients =\(.*\)$/listen.allowed_clients =/g' /etc/php-fpm.d/www.conf

EXPOSE 9090

ENTRYPOINT ["/usr/sbin/php-fpm", "--nodaemonize"]
