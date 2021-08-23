# rust-to-wasm

## Setup

``` shell
git clone git@github.com:wat-aro/rust-to-wasm.git
cd rust-to-wasm
code .
```

コマンドパレットを開き

``` shell
> Show Recommended Extensions
```
と入力し `Remote-Container` をインストール。

以下をコマンドパレットで入力し、コンテナを起動。
``` shell
> Remote-Containers: Reopen in Container
```

## Build

``` shell
wasm-pack build
cd pkg
npm link
cd ../site
npm link hello-wasm
npm start
```
