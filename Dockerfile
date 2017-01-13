FROM buildpack-deps:jessie

RUN apt-get update -qq && apt-get install -y build-essential libmysqld-dev supervisor curl nginx

# Install Supervisor and config
RUN apt-get install -y supervisor
RUN touch /etc/supervisord.conf
RUN echo '[supervisord]'  >> /etc/supervisord.conf
RUN echo 'nodaemon=true'  >> /etc/supervisord.conf
RUN echo 'logfile=/root/tmp/supervisord.log' >> /etc/supervisord.conf
RUN echo 'logfile_maxbytes=50MB' >> /etc/supervisord.conf
RUN echo 'logfile_backups=10' >> /etc/supervisord.conf
RUN echo 'loglevel=info' >> /etc/supervisord.conf
RUN echo 'pidfile=/root/tmp/supervisord.pid' >> /etc/supervisord.conf

RUN echo '[program:unicorn]'             >> /etc/supervisord.conf
RUN echo 'command=/root/bin/endpoint_unicorn' >> /etc/supervisord.conf
RUN echo 'stdout_logfile=/root/tmp/unicorn_out.log' >> /etc/supervisord.conf
RUN echo 'stdout_logfile_maxbytes=10MB' >> /etc/supervisord.conf
RUN echo 'stdout_logfile_backups=3' >> /etc/supervisord.conf
RUN echo 'stderr_logfile=/root/tmp/unicorn_err.log' >> /etc/supervisord.conf
RUN echo 'stderr_logfile_maxbytes=10MB' >> /etc/supervisord.conf
RUN echo 'stderr_logfile_backups=3' >> /etc/supervisord.conf
RUN echo 'autostart=true' >> /etc/supervisord.conf
RUN echo 'autorestart=true' >> /etc/supervisord.conf

RUN echo '[program:nginx]'             >> /etc/supervisord.conf
RUN echo 'command=/usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off;"' >> /etc/supervisord.conf
RUN echo 'stdout_logfile=/root/tmp/nginx_out.log' >> /etc/supervisord.conf
RUN echo 'stdout_logfile_maxbytes=10MB' >> /etc/supervisord.conf
RUN echo 'stdout_logfile_backups=3' >> /etc/supervisord.conf
RUN echo 'stderr_logfile=/root/tmp/nginx_err.log' >> /etc/supervisord.conf
RUN echo 'stderr_logfile_maxbytes=10MB' >> /etc/supervisord.conf
RUN echo 'stderr_logfile_backups=3' >> /etc/supervisord.conf
RUN echo 'autostart=true' >> /etc/supervisord.conf
RUN echo 'autorestart=true' >> /etc/supervisord.conf

WORKDIR /root
ADD Gemfile /root/Gemfile
ADD Gemfile.lock Gemfile.lock
ADD . /root
RUN mkdir /root/tmp
RUN mkdir /root/tmp/cache
RUN mkdir /root/tmp/pids
RUN mkdir /root/tmp/sockets
RUN cp /root/setup/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN RAILS_ENV=production bin/bundle install --without test development --path vendor/bundle

CMD /usr/bin/supervisord -c /etc/supervisord.conf
