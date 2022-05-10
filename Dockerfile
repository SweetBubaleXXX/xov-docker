FROM alpine:3.15
ARG REPO
RUN apk update && apk upgrade
RUN apk add --no-cache vim openssh-client gpg gpg-agent git
RUN mkdir /root/.ssh
COPY ./id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN mkdir /root/xov
RUN git clone $REPO /root/xov
WORKDIR /root/xov
RUN git config core.fileMode false
RUN git config user.name $(echo $RANDOM$RANDOM)
RUN git config user.email "$(git config user.name)@docker"
RUN chmod +x ./xov
RUN chmod +x ./xov.sh
ENTRYPOINT [ "/bin/sh" ]
