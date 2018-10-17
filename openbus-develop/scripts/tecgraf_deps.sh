#!/bin/bash
# function to clone from git specific versions
function git_clone {
  if [ -d "$4" ]; then
    echo "Dependency $4 is already here (modified name, original: $1)"
    return
  fi
  if [ ! -d "$1" ] || [ -n "$4" ] && [ ! -d "$4" ]; then
      echo "Bringing dependency $1..."
      local TARGET="$1"
      # Bring to diferent directory
      if [ -n "$4" ]; then
        TARGET="$4"
      fi
      # Do the clone
      git clone -q https://git.tecgraf.puc-rio.br/$2/$1.git $TARGET
      if [ $? -ne 0 ]; then
        echo "# Cannot bring dependency $1. Check error details."
        exit 1
      fi
      # Change the branch or tag
      if [ -n "$3" ]; then
        cd "$TARGET"
        git checkout "$3"
        cd ..
      fi
  else
    echo "Dependency $1 is already here (original name)"
  fi
}

# Clone projects
for project in "lua openbus-3rd-party" \
    "loop engdist" \
    "oil engdist" \
    "lce engdist" \
    "luuid openbus-3rd-party 1.0" \
    "scs-core-lua scs SCS_CORE_LUA_v1_02_03_2012_05_10 luascs" \
    "scs-core-idl scs SCS_CORE_IDL_v1_02_00_2010_11_09 scs-idl" \
    "lualdap openbus-3rd-party 1.1.0" \
    "luafilesystem openbus-3rd-party 1.4.2" \
    "luasec openbus-3rd-party" \
    "luasocket openbus-3rd-party 2.0.2" \
    "struct openbus-3rd-party 1.2 luastruct" \
    "vararg openbus-3rd-party 1.1 luavararg" \
    "openbus-sdk-lua openbus master luaopenbus" \
    "openbus-audit-agent openbus master luaopenbusaudit" \
    "luasqlite3 openbus-3rd-party" \
    "openbus-idl openbus" \
    "openbus-sdk-idl-lib openbus master openbus-lib-idl" \
    "openbus-idl openbus 02_00 openbus-legacy-idl" \
    "openssl boost-build master openssl.jam" \
    "openldap boost-build master openldap.jam" \
    "uuid boost-build master uuid.jam" \
    "sqlite openbus-3rd-party" \
    "luaiconv openbus-3rd-party" \
    "openbus-core openbus master"
do
  set -- $project
  git_clone $1 $2 $3 $4
done