FROM rust:1.45.0-buster as wasm-pack
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

FROM node:16.7-buster-slim as node
WORKDIR /app
COPY ./site/package.json ./package.json
COPY ./site/package-lock.json ./package-lock.json
RUN npm install

FROM rust:1.45.0-buster
ENV LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo

RUN rustup component add rustfmt --toolchain 1.45.0-x86_64-unknown-linux-gnu
COPY --from=wasm-pack /usr/local/cargo/bin/wasm-pack /usr/local/cargo/bin/wasm-pack
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
