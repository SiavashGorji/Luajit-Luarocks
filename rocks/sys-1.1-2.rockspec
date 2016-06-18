package = "sys"
version = "1.1-2"

source = {
   url = "git://github.com/diz-vara/sys",
   tag = "1.1-2"
}

description = {
   summary = "A system library for Torch",
   detailed = [[
Provides system functionalities for Torch.
   ]],
   homepage = "https://github.com/diz-vara/sys",
   license = "BSD"
}

dependencies = {
   "torch >= 7.0",
}

build = {
   type = "command",
   build_command = [[cmake -E make_directory build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)" && $(MAKE)]],
   install_command = "cd build && $(MAKE) install"
}
