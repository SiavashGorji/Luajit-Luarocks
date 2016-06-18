project(luarocks)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)

SET(INSTALL_INCLUDE_SUBDIR "include") # CACHE STRING "installation include subdirectory name")
SET(INSTALL_BIN_SUBDIR ".") # CACHE STRING "installation executable subdirectory name")
SET(INSTALL_LIB_SUBDIR ".") # CACHE STRING "installation library subdirectory name")
SET(INSTALL_LUA_PATH_SUBDIR "lua") # not editable
SET(INSTALL_LUA_CPATH_SUBDIR ".") # not editable
SET(INSTALL_LUAROCKS_ROCKS_SUBDIR "luarocks") # CACHE STRING "installation luarocks rocks subdirectory name")
SET(INSTALL_LUAROCKS_SYSCONF_SUBDIR "luarocks") # CACHE STRING "installation luarocks sysconfig subdirectory name")


SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
                      "${CMAKE_MODULE_PATH}")



  SET(WINUTILS_DLL_FILES
    win32/bin/7z.dll win32/bin/libeay32.dll win32/bin/libiconv2.dll
    win32/bin/libintl3.dll win32/bin/libssl32.dll)

  INSTALL(FILES ${WINUTILS_DLL_FILES} DESTINATION "${INSTALL_BIN_SUBDIR}")
   
  SET(WINUTILS_EXE_FILES
    win32/bin/cmake.cmd
    win32/bin/7z.exe win32/bin/chmod.exe win32/bin/cp.exe
    win32/bin/find.exe win32/bin/ls.exe win32/bin/md5sum.exe
    win32/bin/mkdir.exe win32/bin/mv.exe win32/bin/objdump.exe
    win32/bin/pwd.exe win32/bin/rm.exe win32/bin/rmdir.exe
    win32/bin/test.exe win32/bin/uname.exe win32/bin/wget.exe)
  
  INSTALL(PROGRAMS ${WINUTILS_EXE_FILES} DESTINATION "${INSTALL_BIN_SUBDIR}")
    
  SET(WGET_EXECUTABLE_NAME "wget")
  SET(MD5_EXECUTABLE_NAME "md5sum")
  SET(UNAME_M "x64")
  SET(SHEBANG
"rem=rem --[[
@setlocal&  set PATH=${CMAKE_INSTALL_PREFIX}/${INSTALL_BIN_SUBDIR};%PATH% & set luafile=\"%~f0\" & if exist \"%~f0.bat\" set luafile=\"%~f0.bat\"
@${CMAKE_INSTALL_PREFIX}/${INSTALL_BIN_SUBDIR}/${LUA_EXE_NAME}.exe %luafile% %*&  exit /b ]]")



SET(LUAROCKS_FILES
  fs/unix/tools.lua fs/unix.lua fs/win32/tools.lua fs/win32.lua fs/lua.lua
  fs/x64/tools.lua fs/x64.lua 
  persist.lua list.lua require.lua repos.lua dir.lua make_manifest.lua
  command_line.lua install.lua build/command.lua build/cmake.lua
  build/make.lua build/builtin.lua fetch/cvs.lua fetch/git.lua
  fetch/sscm.lua tools/patch.lua fetch/svn.lua tools/zip.lua tools/tar.lua
  pack.lua type_check.lua make.lua path.lua remove.lua fs.lua manif.lua
  add.lua deps.lua build.lua search.lua show.lua manif_core.lua fetch.lua
  unpack.lua validate.lua cfg.lua download.lua help.lua util.lua index.lua
  cache.lua refresh_cache.lua loader.lua admin_remove.lua fetch/hg.lua
  fetch/git_file.lua new_version.lua lint.lua purge.lua
  doc.lua fetch/git_http.lua path_cmd.lua upload.lua upload/api.lua upload/multipart.lua
  write_rockspec.lua)

FOREACH(LUAROCKS_FILE ${LUAROCKS_FILES})
  GET_FILENAME_COMPONENT(_subpath "${LUAROCKS_FILE}" PATH)
  INSTALL(FILES "src/luarocks/${LUAROCKS_FILE}" DESTINATION "${INSTALL_LUA_PATH_SUBDIR}/luarocks/${_subpath}")
ENDFOREACH()

CONFIGURE_FILE("src/luarocks/site_config.lua.in" "${CMAKE_CURRENT_BINARY_DIR}/src/luarocks/site_config.lua")
INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/src/luarocks/site_config.lua" DESTINATION "${INSTALL_LUA_PATH_SUBDIR}/luarocks")

CONFIGURE_FILE("src/luarocks/config.lua.win.in" "${CMAKE_CURRENT_BINARY_DIR}/src/luarocks/config.lua")
INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/src/luarocks/config.lua" DESTINATION "${INSTALL_LUAROCKS_SYSCONF_SUBDIR}")


CONFIGURE_FILE("src/bin/luarocks.in" "${CMAKE_CURRENT_BINARY_DIR}/src/bin/luarocks.bat")
CONFIGURE_FILE("src/bin/luarocks-admin.in" "${CMAKE_CURRENT_BINARY_DIR}/src/bin/luarocks-admin.bat")
INSTALL(PROGRAMS "${CMAKE_CURRENT_BINARY_DIR}/src/bin/luarocks.bat" DESTINATION "${INSTALL_BIN_SUBDIR}")
INSTALL(PROGRAMS "${CMAKE_CURRENT_BINARY_DIR}/src/bin/luarocks-admin.bat" DESTINATION "${INSTALL_BIN_SUBDIR}")
