LuaJIT + Luarocks + Torch7 on Windows
=============================

# What's the point? #
This is an easy to use installation for _recent_ versions of LuaJIT, luarocks, torch7 and various torch7 modules on Windows.
The provided LuaJIT, luarocks, torch7 and its modules point to their respective git repository. Unless specified (i.e. necessary), no changes are made, except for the compilation and installation processes.
This repository is forked from [torch/luajit-rocks](https://github.com/torch/luajit-rocks) with imported changes from [diz-vara/luajit-rocks](https://github.com/diz-vara/luajit-rocks).

# Pre-requisites

Install [CMake](http://cmake.org) and [Git](https://git-scm.com/) on your system.

Install a version of [Visual Studio 2013/2015](https://www.visualstudio.com/) (Community editions are free) on your system.

# Installation

## 1. luaJIT and luarocks
To install luaJIT and luarocks on Windows,

```sh
git clone https://github.com/SiavashGorji/luajit-rocks.git
cd luajit-rocks
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/your/prefix
```

Then under Unix systems:
```sh
make install
```

Under Windows:
```sh
nmake install
```

Note: we do not recommend (nor we support) installation under Cygwin.

## Additional CMake flags

  - If you prefer vanilla Lua 5.1 instead of LuaJIT, use `-DWITH_LUA51=ON`
  - If you prefer vanilla Lua 5.1 with reference counting instead of LuaJIT, use `-DWITH_LUA51RC=ON` (*experimental*)
  - If you prefer vanilla Lua 5.2 instead of LuaJIT, use `-DWITH_LUA52=ON`
  - If you prefer LuaJIT 2.1 instead of LuaJIT 2.0, use `-DWITH_LUAJIT21=ON`
