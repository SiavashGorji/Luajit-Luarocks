CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.8)

PROJECT(luajit-luarocks-torch7)

# We want release compilation by default
IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE)
ENDIF(NOT CMAKE_BUILD_TYPE)


SET(LUA_EXE_NAME luajit)
SET(LUA_VERSION 5.1)
ADD_SUBDIRECTORY(LuaJIT)
ADD_SUBDIRECTORY(luarocks)
