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

This will download the luaJIT/luarocks source files into the luajit-luarocks folder, creates and moves to the build directory within it.

Note that if you do not use the git command and download the the repository directly from https://github.com/SiavashGorji/luajit-luarocks-torch7, the unzipped directory would be named luajit-luarocks-torch7. Either rename this or change the argument of the second cd command above.

Now, choose a destination to install luajit-luarocks-torch7 (e.g. C:\Programs\LuaJIT) and run

```sh
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\LuaJIT
nmake
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\LuaJIT -P cmake_install.cmake
```

The .. argument to the cmake commands tells them the location of the root CMakeLists.txt (which in our case is located in C:\Programs\luajit-luarocks), relative to the current directory (in our case C:\Programs\luajit-luarocks\build). This is usefull since cmake puts all of its generated makefiles into the current directory.
The -G "NMake Makefiles" flag tells cmake to generate NMake files instead of a Visual Studio Solution (which it does by fefault on Windows).
The nmake command actually builds the source files using the cmake-generated make files. 
The second cmake command copies (installs) all the required files into the destination directory.
After these commands, you can close your NTCP and delete the luajit-luarocks folder (if you want).

Finally, we need to add some variables to the Environment Variables and add the installation directory to the Windows path:
First, add the installation directory (in our case C:\Programs\LuaJIT) to the System Path. You can easily do this using a regular Command Prompt (you can easily open this by pressing WindowsKey+X followed by C (or A for admin)).
Keep in mind that the Command Prompt sets this for the current user only.

```sh
setx path "C:\Programs\LuaJIT;%path%"
```

Now, open a regular Command Prompt (exit and reopen if it's already open) and run

```sh
luajit -e print(package.path)
```

We need to create an Environment Variable called LUA_PATH and set its value to the results of the above command (which in our case was ".\?.lua;C:\Programs\LuaJIT\lua\?.lua;C:\Programs\LuaJIT\lua\?\init.lua;").
Again, we can do this using a regular Command Prompt.

```sh
setx LUA_PATH .\?.lua;C:\Programs\LuaJIT\lua\?.lua;C:\Programs\LuaJIT\lua\?\init.lua;
```
Similarly, we need to create LUA_CPATH and set its value to the output of

```sh
luajit -e print(package.cpath)
```

which in our case was ".\?.dll;C:\Programs\LuaJIT\?.dll;C:\Programs\LuaJIT\loadall.dll".

```sh
setx LUA_CPATH .\?.dll;C:\Programs\LuaJIT\?.dll;C:\Programs\LuaJIT\loadall.dll
```

Finally, we need to set LUA_DEV to the Lua installation directory

```sh
setx LUA_DEV C:\Programs\LuaJIT
```

You can check your luarocks installation by running "luarocks" or "luarocks list" in a regular Command Prompt. 
The former should display the help for using luarocks and the latter should return the installed packages, which are none for now.

## 2. Torch7

