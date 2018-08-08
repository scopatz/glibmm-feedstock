#!/usr/bin/env bash
set -ex

export CFLAGS="${CFLAGS} -O3"
export CXXFLAGS="${CXXFLAGS} -O3"

if [ "$(uname)" == "Linux" ]; then
  # need to enable C++11 on linux explicitly
  export CFLAGS="${CFLAGS} -std=c++11"
  export CXXFLAGS="${CXXFLAGS} -std=c++11"
fi

# configure, make, install, check
sed -e '/^libdocdir =/ s/$(book_name)/glibmm-'"${PKG_VERSION}"'/' \
    docs/Makefile.in > docs/Makefile.in.new
mv docs/Makefile.in.new docs/Makefile.in
./configure --prefix="${PREFIX}" --exec-prefix="${PREFIX}" \
  --disable-dependency-tracking \
  || { cat config.log; exit 1; }
make
make install

# remove all libtool files
find $PREFIX -name '*.la' -delete