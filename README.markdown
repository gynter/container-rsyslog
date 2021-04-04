# Docker RSyslog (https://github.com/gynter/docker-rsyslog)

A generic Docker image for [RSyslog](https://www.rsyslog.com/). This image is designed to run securely on non-systemd
(i.e Alpine) containers as unprivileged user (UID/GID 1000).

See https://github.com/gynter/rsyslog-docker-compose-example for deployment example using Docker Compose.

## Important files and directories

- `/etc/rsyslog.conf` - Main rsyslogd configuration file, can be overwritten by a bind mount;
- `/etc/rsyslog.d/` - Extra rsyslogd configuration files, can be mounted as a volume. Files must have `*.conf` extension
  to be loaded by rsyslogd;
- `/srv/rsyslog/` - rsyslogd working directory, PID file will be also created there. It's recommended to mount this
  directory as a volume if there's a need to persist working files (i.e when using queue files to store data on file
  system);
- `/logs/` - A directory for storing log files. Should be mounted as a volume.

## License

Parts of RSyslog official documentation were used in configuration file comments, therefore the license is same as
RSyslog documentation, Apache License Version 2.0. The copy of the license can be found in file `LICENSE`.
