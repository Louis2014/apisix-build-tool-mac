#!/usr/bin/env bash
set -euo pipefail
set -x

export openssl_prefix=/opt/homebrew/opt/openresty-openssl111
export zlib_prefix=/opt/homebrew/opt/zlib
export pcre_prefix=/opt/homebrew/opt/pcre


export cc_opt="-DNGX_LUA_ABORT_AT_PANIC -I${zlib_prefix}/include -I${pcre_prefix}/include -I${openssl_prefix}/include"
export ld_opt="-L${zlib_prefix}/lib -L${pcre_prefix}/lib -L${openssl_prefix}/lib -Wl,-rpath,${zlib_prefix}/lib:${pcre_prefix}/lib:${openssl_prefix}/lib"
#-DLUAJIT_NUMMODE=2当我们把它在编译时设置为 2 时，对于能够用 32 位整数表示的 number，LuaJIT 会用 int32 表示，而不是一概用 double 来表示。
#设置 LUAJIT_NUMMODE=2 会让程序快一点，因为 CPU 更擅长对整数进行计算
export luajit_xcflags="-DLUAJIT_ASSERT -DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT"
#OPENRESTY 安装路径
export OR_PREFIX=/opt/homebrew/Cellar/openresty-debug
export debug_args=--with-debug
#相关安装包下载路径
export MODULE_PREFIX=/Users/louis/Downloads/tmp

./build-darwin-arm64-apisix-base.sh latest
