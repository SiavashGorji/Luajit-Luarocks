LuaJIT + Luarocks + Torch7 on Windows
=============================

This is an easy to use installation for _recent_ versions of LuaJIT, luarocks, torch7 and various torch7 modules on Windows.
The provided LuaJIT, luarocks, torch7 and its modules point to their respective git repository. Unless specified (i.e. necessary), no changes are made, except for the compilation and installation processes.
This repository is forked from [torch/luajit-rocks](https://github.com/torch/luajit-rocks) with imported changes from [diz-vara/luajit-rocks](https://github.com/diz-vara/luajit-rocks).

# Current Module Versions
[LuaJIT](https://github.com/LuaJIT/LuaJIT/tree/v2.1) 2.1.0-beta2

[luarocks](https://github.com/keplerproject/luarocks) 2.2.0-beta1

# Pre-requisites
Install [CMake](http://cmake.org), [Git](https://git-scm.com/), and a version of [Visual Studio 2013/2015](https://www.visualstudio.com/) (Community editions are free) on your system.


# Installation
During all the following steps, we use the Visual Studio Native Tools Command Prompt, which is a command prompt with appropriate environment variables set. You can locate it inside C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\Shortcuts for VS2013, and C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2015\Visual Studio Tools\Windows Desktop Command Prompts for VS2015.

I recommend using the 64-bit Native Tools (e.g. VS2013 x64 Native Tools Command Prompt or VS2015 x64 Native Tools Command Prompt). We will refer to this by NTCP in the reset of this guide. Make sure you do not switch from 32-bit to 64-bit (or vice versa) compilation at any point.

## 1. luaJIT and luarocks
Choose a directory to put the source files into, preferably a short path with no spaces (e.g. C:\Programs).
On your NTCP run,

```sh
cd C:\Programs
git clone https://github.com/SiavashGorji/luajit-rocks.git
cd luajit-luarocks
mkdir build
cd build
```

This will download the luaJIT/luarocks source files and creates the build directory.
Now, choose a destination to install luajit-luarocks-torch7 (e.g. C:\Programs\LuaJIT) and run

```sh
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\LuaJIT
nmake
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\LuaJIT -P cmake_install.cmake
```

The -G "NMake Makefiles" flag tells cmake to generate NMake files instead of a Visual Studio Solution (which it does by fefault on Windows).
The nmake command actually builds the source files using the cmake-generated make files. 
The second cmake command copies (installs) all the required files into the destination directory.
After these commands, you can close your NTCP and delete the luajit-luarocks folder (if you want).

Before proceeding, we need to make some neccessary changes to the environmental variables and the Windows path.


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
