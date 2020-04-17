FROM gcr.io/kaniko-project/executor:latest

FROM alpine
COPY --from=0 /kaniko/ /kaniko

RUN mkdir -p /cache && \
    apk add ca-certificates && \
    chmod g=u /etc/passwd && \
    chgrp -R 0 /kaniko /var /cache /etc /lib && \
    chmod -R g=u /kaniko /var /cache /etc /lib

COPY uid_entrypoint /
ENTRYPOINT ["/uid_entrypoint"]
USER 1001
