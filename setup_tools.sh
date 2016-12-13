printf '\e[1;31m%-6s\e[m\n' "Note: This script does not deal with interruptions. Please let it finish!"
if [ ! -d src ]; then
mkdir src
cd src && (
    git clone https://github.com/bminor/glibc;
    git clone https://github.com/bminor/binutils-gdb;
    git clone https://github.com/gcc-mirror/gcc;
    (cd glibc && git am ../patches/glibc/*.patch);
    (cd binutils-gdb && git am ../patches/binutils-gdb/*.patch);
    (cd gcc && git am ../patches/gcc/*.patch);
)
fi
export BASE_DIR=$PWD
export MAKE_OPT=-j4
if [ ! -d build ]; then
    mkdir ld
    (cd ld && $BASE_DIR/src/binutils-gdb/configure --prefix=$BASE_DIR/usr \
        --enable-ld=yes --enable-gdb=no && make $MAKE_OPT && make $MAKE_OPT install);
    # Make sure the new ld is on the path for building gcc and glibc
    export PATH=$BASE_DIR:$PATH
    mkdir gcc
    (cd gcc && $BASE_DIR/src/gcc/configure --prefix=$BASE_DIR/usr --enable-languages=c,c++ \
         && make $MAKE_OPT && make $MAKE_OPT install);
    mkdir glibc
    (cd glibc && $BASE_DIR/src/glibc/configure --prefix=$BASE_DIR/usr \
        CC=$BASE_DIR/usr/bin/gcc && make $MAKE_OPT && make $MAKE_OPT install);
fi
printf '\e[1;32m%-6s\e[m\n' "Done (if you didn't interrupt it earlier)"
