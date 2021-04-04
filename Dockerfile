#
# Docker RSyslog (https://github.com/gynter/docker-rsyslog)
#
# See https://github.com/gynter/rsyslog-docker-compose-example for deployment example using Docker Compose.
#

# Use latest Alpine Linux.
FROM alpine:latest

# Install RSyslog. We also need tzdata for TZ env variable.
RUN apk update && \
    apk add --no-cache rsyslog tzdata

# Add unprivileged user for RSyslog.
RUN addgroup -g 1000 app && \
    adduser -H -g "Unprivileged application user" -G app -D -u 1000 app

# Create directory for extra confguration files and logs.
RUN mkdir -p /etc/rsyslog.d /srv/rsyslog /logs

# Copy configuration files.
COPY rsyslog.conf /etc/
COPY 10-local-file-logging.conf /etc/rsyslog.d/

# Set permissions.
RUN chown -R root:1000 /etc/rsyslog.conf /etc/rsyslog.d; \
    chmod -R 0750 /etc/rsyslog.d; \
    find /etc/rsyslog.conf /etc/rsyslog.d/ -type f -exec chmod 0440 {} \; ; \
    chown -R root:root /srv; \
    chmod -R 0711 /srv; \
    chown -R 1000:1000 /srv/rsyslog /logs; \
    chmod -R 0700 /srv/rsyslog /logs; \
    find /srv/rsyslog -type f -exec chmod 0600 {} \;

# Change to unprivileged user.
USER 1000:1000

# Run rsyslogd in foreground with custom PID file path, since it's running under unprivileged user.
ENTRYPOINT [ "sh", "-c", "/usr/sbin/rsyslogd -n -i /srv/rsyslog/rsyslog.pid" ]
