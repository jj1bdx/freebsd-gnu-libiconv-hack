#!/bin/sh

# GNU libiconv/libcharset wrapper

# Original source from Fumiyasu Sato's
# https://github.com/fumiyas/wcwidth-cjk
# License: BSD 2-clause

# define this in your local directory
GNUICONVLIBDIR=/home/kenji/lib

if [ $# -lt 1 ]; then
  echo "Usage: $0 COMMAND [ARGUMENT ...]" 1>&2
  exit 1
fi

libcharset_so="${GNUICONVLIBDIR}/libcharset.so"
libiconv_so="${GNUICONVLIBDIR}/libiconv.so"

case " ${LD_PRELOAD} " in
*":${libiconv_so}:"*)
  ;;
*)
  LD_PRELOAD="${LD_PRELOAD:+$LD_PRELOAD}:${libiconv_so}"
  ;;
esac

case " ${LD_PRELOAD} " in
*":${libcharset_so}:"*)
  ;;
*)
  LD_PRELOAD="${LD_PRELOAD:+$LD_PRELOAD}:${libcharset_so}"
  ;;
esac

if [ x"$1" = x"--sh-init" ]; then
  echo "LD_PRELOAD='${LD_PRELOAD}'"
  echo "export LD_PRELOAD"
  exit 0
fi

export LD_PRELOAD

exec "$@"
exit 1

# BSD 2-clause license:
# (see http://opensource.org/licenses/BSD-2-Clause for the details)
#
# Copyright (c) 2013, SATOH Fumiyasu @ OSS Technology Corp., Japan, and
# Kenji Rikitake.  All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.  Redistributions
# in binary form must reproduce the above copyright notice, this list of
# conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.  THIS SOFTWARE IS
# PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
