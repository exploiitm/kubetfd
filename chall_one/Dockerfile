FROM pwn.red/jail

COPY --from=ubuntu:20.04 / /srv

RUN mkdir /srv/app
COPY vuln /srv/app/run
COPY flag /srv/app


