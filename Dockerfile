FROM node:16.7-buster-slim as node

FROM rust:1.45.0-buster as rust-builder
RUN rustup component add rustfmt --toolchain 1.45.0-x86_64-unknown-linux-gnu

FROM rust-builder as wasm-pack
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

FROM rust:1.45.0-buster
ENV LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=rust-builder /usr/local/cargo/bin/rustfmt /usr/local/cargo/bin/rustfmt
RUN true # これがないとなぜか失敗する
COPY --from=wasm-pack /usr/local/cargo/bin/wasm-pack /usr/local/cargo/bin/wasm-pack
