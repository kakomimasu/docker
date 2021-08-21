FROM denoland/deno:ubuntu-1.12.2

RUN apt-get -qq update \
 && apt-get -qq install -y --no-install-recommends curl ca-certificates unzip \
 && curl -fsSL https://github.com/codeforkosen/Kakomimasu/archive/refs/tags/v1.0.0-beta.zip \
         --output kakomimasu.zip \
 && unzip kakomimasu.zip \
 && rm kakomimasu.zip \
 && chmod 755 Kakomimasu-1.0.0-beta \
 && mv Kakomimasu-1.0.0-beta /usr/bin/kakomimasu \
 && apt-get -qq remove --purge -y curl ca-certificates unzip \
 && apt-get -y -qq autoremove \
 && apt-get -qq clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/bin/kakomimasu
RUN deno cache apiserver/deps.ts
RUN deno cache apiserver/apiserver.ts
EXPOSE 8880
CMD ["run", "-A", "apiserver/apiserver.ts"]

