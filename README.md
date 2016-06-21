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
If you want CUDA capabalities, install [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) after installing Visual Studio.

# Installing LuaJIT/Luarocks/Torch7
During all the following steps, we use the Visual Studio Native Tools Command Prompt, which is a command prompt with appropriate environment variables set. You can locate it inside C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\Shortcuts for VS2013, and C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2015\Visual Studio Tools\Windows Desktop Command Prompts for VS2015.

I recommend using the 64-bit Native Tools (e.g. VS2013 x64 Native Tools Command Prompt or VS2015 x64 Native Tools Command Prompt). We will refer to this by NTCP in the reset of this guide. Make sure you do not switch from 32-bit to 64-bit (or vice versa) compilation at any point.

## 1. LuaJIT and Luarocks
Choose a directory to put the source files into, preferably a short path with no spaces (e.g. C:\Programs).
On your NTCP run,

```sh
cd C:\Programs
git clone https://github.com/SiavashGorji/luajit-rocks.git
cd luajit-rocks
mkdir build
cd build
```

This will first download the luaJIT/luarocks source files into the luajit-rocks folder, then creates and moves to the build directory within it.

Note that if you do not use the git command and download the the repository directly from https://github.com/SiavashGorji/luajit-luarocks-torch7, the unzipped directory would be named luajit-luarocks-torch7. Either rename this or change the argument of the second cd command above.

Now, choose a destination to install luajit-luarocks-torch7. Note that while this could be anywhere, I suggest to use an "install" folder within the luajit-luarocks directory (i.e. C:\Programs\luajit-rocks\install). Note that the torch installation will create a folder (share) outside of the installation directory (in our case C:\Programs\luajit-rocks) later on. Run

```sh
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\luajit-rocks\install
nmake
cmake .. -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=C:\Programs\luajit-rocks\install -P cmake_install.cmake
```

The .. argument to the cmake commands tells them the location of the root CMakeLists.txt (which in our case is located in C:\Programs\luajit-rocks), relative to the current directory (in our case C:\Programs\luajit-rocks\build). This is usefull since cmake puts all of its generated makefiles into the current directory.
The -G "NMake Makefiles" flag tells cmake to generate NMake files instead of a Visual Studio Solution (which it does by default on Windows).
The nmake command actually builds the source files using the cmake-generated make files. 
The second cmake command copies (installs) all the required files into the destination directory.
After these commands, you can close your NTCP. Do no delete the luajit-rocks folder (even if you did not put the installation folder within it), we are going to need it later on.

Finally, we need to add some variables to the Environment Variables and add the installation directory to the Windows path:
First, add the installation directory (in our case C:\Programs\luajit-rocks\install) to the System Path. You can easily do this using a regular Command Prompt (you can easily open this by pressing WindowsKey+X followed by C (or A for admin)).
Keep in mind that the Command Prompt sets this for the current user only. The easier way is to use __Control Panel|System|Advanced|Environment variables menu__.

```sh
setx path "C:\Programs\luajit-rocks\install;%path%"
```

Now, open a regular Command Prompt (exit and reopen if it's already open) and run

```sh
luajit -e print(package.path)
```

We need to create an Environment Variable called LUA_PATH and set its value to the results of the above command (which in our case was ".\?.lua;C:\Programs\luajit-rocks\install\lua\?.lua;C:\Programs\luajit-rocks\install\lua\?\init.lua;").
Again, we can do this using a regular Command Prompt.

```sh
setx LUA_PATH .\?.lua;C:\Programs\luajit-rocks\install\lua\?.lua;C:\Programs\luajit-rocks\install\lua\?\init.lua;
```
Similarly, we need to create LUA_CPATH and set its value to the output of

```sh
luajit -e print(package.cpath)
```

which in our case was ".\?.dll;C:\Programs\luajit-rocks\install\?.dll;C:\Programs\luajit-rocks\install\loadall.dll".

```sh
setx LUA_CPATH .\?.dll;C:\Programs\luajit-rocks\install\?.dll;C:\Programs\luajit-rocks\install\loadall.dll
```

Finally, we need to set LUA_DEV to the Lua installation directory

```sh
setx LUA_DEV C:\Programs\luajit-rocks\install
```

You can check your luarocks installation by running "luarocks" or "luarocks list" in a regular Command Prompt. 
The former should display the help for using luarocks and the latter should return the installed packages, which are none for now.

Note that in the installation directory, there is a cmake.cmd which automatically appends any cmake commands (which are called by luarocks) with the -G "NMake Makefiles" flag. In order for this to work, you should make sure that the installation directory precedes cmake installation directory.

## 2. Torch7
From this point on, we will use luarocks to install all the required packages, including torch7 and its modules.
Basically, there are two types of lua packages, ones written completely in lua, and ones that contain C/C++ implementation.
Whenever we want to install a package containing C codes using luarocks, we need to run luarocks within our NTCP instead of a regular Command Prompt (to be safe, you can always use NTCP).

Before installing torch7, we need to install cwrap (purly lua code) and paths (containing C code) modules. On a regular Command Prompt or the NTCP, run

```sh
luarocks install cwrap
```
Note that if you run "luarocks list" after this, you should see cwrap in the list of installed modules. On the NTCP, run,

```sh
luarocks install paths
```

We can now procede by installing torhc7 on the NTCP,

```sh
luarocks install torch
```
To test the torch installation, we can create and display a 2x3x4 randomly initialized tensor on a regular Command Prompt by

```sh
luajit
require "torch"
print(torch.Tensor(2,3,4))
```
You can exit from luajit by pressing Ctrl+C.

# Installing Torch Modules
When you install torch on Unix environments, it will automatically installs "lots of nice goodies". 
In the following section, we try to install them (i.e. most of them) one by one using luarocks installer.
I suggest to use your NTCP while installing each of them. We will begin with the easy ones first.

```sh
luarocks install luafilesystem
luarocks install penlight
luarocks install sundown
luarocks install dok
luarocks install xlua
luarocks install nn
luarocks install graph
luarocks install nngraph
luarocks install image
luarocks install optim
luarocks install gnuplot
luarocks install env
luarocks install qtlua
luarocks install graphicsmagick
luarocks install argcheck
luarocks install fftw3
```

To install some of the lua/torch modules on Windows, we need to make some changes to them.
You can find all such modules inside the extra folder in the luajit-rocks modules. To install these, we will use luarocks local installation capabality (i.e. using "make" instead of "install").
Basically, all you need to do is to cd your NTCP to the main directory of  each module, and run luarocks make path-to-module-rockspec-file.
```sh
cd C:\Programs\luajit-rocks\extra\lua-cjson
luarocks make lua-cjson-2.1devel-1.rockspec

cd C:\Programs\luajit-rocks\extra\luaffifb
luarocks make luaffi-scm-1.rockspec

cd C:\Programs\luajit-rocks\extra\sys
luarocks make sys-1.1-0.rockspec

cd C:\Programs\luajit-rocks\extra\torch-signal
luarocks make ./rocks/signal-scm-1.rockspec

```


Currently not working:
```sh
trepl
threads
audio
qttorch
```
