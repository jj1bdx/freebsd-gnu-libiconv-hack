# GNU libiconv port

This directory is a copy from FreeBSD Ports directory `converters/libiconv` of `libiconv-1.14_1`, as of 31-OCT-2013.

Kenji Rikitake comments out the IGNORE flag in the original Makefile.

## How to compile and install the shared libraries

    # Shared library must be compiled as root
    sudo {whatever shell you like}
    umask 022
    make
    exit
    # Install to your own library by your privilege
    # NOTE: you need libiconv.so AND libcharset.so together
    cp work/libiconv-1.14/lib/.libs/libiconv.so.3 ${YOURLIB}/libiconv.so
    cp work/libiconv-1.14/lib/libcharset.so.1 ${YOURLIB}/libcharset.so
    chmod u+x ${YOURLIB}/libiconv.so ${YOURLIB}/libcharset.so

## NOTE WELL

This is a `LD_PRELOAD` hack; I do not recommend enabling GNU libiconv as a regular environment for FreeBSD 10 and later.

*Leaving GNU iconv active in a login shell will result in unwanted consequences; it may break the Port tree and other programs when you accidentally start the building procedure in the shell.*
