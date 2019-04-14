FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    curl

RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo tresorit
USER tresorit
WORKDIR /home/tresorit

RUN curl -LO https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run && \
    chmod +x ./tresorit_installer.run && \
    echo "N " | ./tresorit_installer.run --update-v2 . && \
    rm ./tresorit_installer.run && \
    mkdir -p /home/tresorit/Profiles \
             /home/tresorit/external

VOLUME /home/tresorit/Profiles /home/tresorit/external
USER root

COPY start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]
CMD ["start"]
