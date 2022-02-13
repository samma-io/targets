FROM alpine/helm:3.5.4



RUN apk add --no-cache --update bash curl sed ncurses git unzip

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


RUN curl -sL "https://github.com/mikefarah/yq/releases/download/v4.11.2/yq_linux_amd64" -o yq && chmod +x yq && mv yq /usr/local/bin/yq


ENV GLIBC_VER=2.31-r0


ENV HOME=/var/tmp
ENV HELM_REPOSITORY_CACHE=/var/tmp


WORKDIR /apps

ENTRYPOINT ["helm"]
CMD ["--help"]
