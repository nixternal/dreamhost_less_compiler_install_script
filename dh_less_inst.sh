#!/bin/sh
###############################################################################
##                                                                           ##
## Dreamhost Shared Server LESS Compiler Install Script                      ##
##                                                                           ##
## Copyright (C) 2012 Richard A. Johnson <nixternal@gmail.com>               ##
##                                                                           ##
## This program is free software: you can redistribute it and/or modify      ##
## it under the terms of the GNU General Public License as published by      ##
## the Free Software Foundation, either version 3 of the License, or         ##
## (at your option) any later version.                                       ##
##                                                                           ##
## This program is distributed in the hope that it will be useful,           ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of            ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the              ##
## GNU General Public License for more details.                              ##
##                                                                           ##
## You should have received a copy of the GNU General Public License         ##
## along with this program.  If not, see <http://www.gnu.org/licenses/>.     ##
##                                                                           ##
## Usage:                                                                    ##
##      ./dh_less_inst.sh                                                    ##
##                                                                           ##
## After installing, add the following 2 lines to your shell rc file. For    ##
## default Linux shell on Dreamhost, this is ~/.bash_profile and for ZSH     ##
## you should already know what to do, but in case you don't, source your    ##
## ~/.zshrc file. Or, if you don't know how to source it, then just log out  ##
## and log back in :)                                                        ##
##                                                                           ##
## Uninstallation:  If you haven't installed anything else to                ##
## ~/.local/usr you can just do the following:                               ##
##      rm -rf ~/.local                                                      ##
## Otherwise, you have to go through and cherry pick the files that were     ##
## installed. If I weren't so lazy, I would make this script uninstall for   ##
## you.                                                                      ##
##                                                                           ##
## Compress your LESS files until you can't take it anymore. Enjoy!          ##
##                                                                           ##
## If you have any issues with this script try and see if I blogged about it ##
## at http://www.nixternal.com/ or email me at the address listed above in   ##
## the copyright notice. If you don't know what this script does, then you   ##
## probably don't need the LESS Compiler or shouldn't be running shell       ##
## shell scripts on a shared server that isn't yours. If this script causes  ##
## your website or Dreamhost go down, or kill innocent kitties in a galaxy   ##
## far far away, your problem, not mine.                                     ##
##                                                                           ##
###############################################################################

REPOARCHIVE="http://archive.ubuntu.com/ubuntu/pool/"
PWD=`pwd`
PREFIX="$HOME/local"
TMPDIR="${PWD}/dhtmp"

setup() {
    mkdir -p ${PREFIX}/usr/lib ${PREFIX}/usr/bin
    mkdir -p ${TMPDIR}
    get_lesscss
    get_node
    get_libcares
    get_libssl
    get_libev
    get_libicu
    get_libv8
}

clean() {
    rm -rf ${TMPDIR}
    rm -rf ${PREFIX}/lib
    rm -rf ${PREFIX}/usr/include
    rm -rf ${PREFIX}/usr/share
    rm -rf ${PREFIX}/usr/lib/nodejs
    rm -rf ${PREFIX}/usr/lib/x86_64-linux-gnu
}

completed() {
    echo "Download and install of $1 complete..."
}

get_lesscss() {
    git clone -q git://github.com/cloudhead/less.js.git ${TMPDIR}/less
    mv ${TMPDIR}/less/bin/lessc ${PREFIX}/usr/bin/
    mv ${TMPDIR}/less/lib/less ${PREFIX}/usr/lib/
    completed lesscss
}

get_node() {
    NODEJSPKG="nodejs_0.4.12-1ubuntu2_amd64.deb"
    NODEJSPKGURI="${REPOARCHIVE}universe/n/nodejs/${NODEJSPKG}"
    wget -q ${NODEJSPKGURI} -P ${TMPDIR}
    dpkg -x ${TMPDIR}/${NODEJSPKG} ${PREFIX}
    completed node.js
}

get_libcares() {
    LIBCARESPKG="libc-ares2_1.7.5-1_amd64.deb"
    LIBCARESPKGURI="${REPOARCHIVE}main/c/c-ares/${LIBCARESPKG}"
    wget -q ${LIBCARESPKGURI} -P ${TMPDIR}
    dpkg -x ${TMPDIR}/${LIBCARESPKG} ${PREFIX}
    mv ${PREFIX}/usr/lib/x86_64-linux-gnu/libcares* ${PREFIX}/usr/lib/
    completed libc-ares
}

get_libssl() {
    LIBSSLPKG="libssl1.0.0_1.0.0e-3ubuntu1_amd64.deb"
    LIBSSLPKGURI="${REPOARCHIVE}main/o/openssl/${LIBSSLPKG}"
    wget -q ${LIBSSLPKGURI} -P ${TMPDIR}
    dpkg -x ${TMPDIR}/${LIBSSLPKG} ${PREFIX}
    mv ${PREFIX}/lib/x86_64-linux-gnu/* ${PREFIX}/usr/lib/
    completed libssl
}

get_libev() {
    LIBEVPKG="libev-4.04.tar.gz"
    LIBEVPKGURI="http://dist.schmorp.de/libev/Attic/${LIBEVPKG}"
    wget -q ${LIBEVPKGURI} -P ${TMPDIR}
    cd ${TMPDIR} && tar -xf ${LIBEVPKG} && cd libev-4.04
    ./configure --prefix=${PREFIX}/usr >/dev/null
    make > /dev/null 2>&1
    make install > /dev/null 2>&1
    cd ${PWD}
    completed libev
}

get_libicu() {
    LIBICUPKG="libicu48_4.8.1.1-3_amd64.deb"
    LIBICUPKGURI="${REPOARCHIVE}main/i/icu/${LIBICUPKG}"
    wget -q ${LIBICUPKGURI} -P ${TMPDIR}
    dpkg -x ${TMPDIR}/${LIBICUPKG} ${PREFIX}
    completed libicu
}

get_libv8() {
    LIBV8PKG="libv8-3.4.14.21_3.4.14.21-5ubuntu1_amd64.deb"
    LIBV8PKGURI="${REPOARCHIVE}universe/libv/libv8/${LIBV8PKG}"
    wget -q ${LIBV8PKGURI} -P ${TMPDIR}
    dpkg -x ${TMPDIR}/${LIBV8PKG} ${PREFIX}
    completed libv8
}

echo "***********************************************************************"
echo "*                                                                     *"
echo "* Dreamhost Shared Server LESS Compiler Installation Script           *"
echo "*                                                                     *"
echo "* Starting the process of downloading and installing all apps         *"
echo "* necessary to use LESS on Dreamhost. This should only take a minute. *"
echo "*                                                                     *"
echo "***********************************************************************"
setup
clean
echo "***********************************************************************"
echo "*                                                                     *"
echo "* Completion Successful!                                              *"
echo "*                                                                     *"
echo "* Next step is to add the following to your .bash_profile or .zshrc   *"
echo "* file in your home directory on the Dreamhost shared server:         *"
echo "*                                                                     *"
echo "*     export LD_LIBRARY_PATH=$HOME/${PREFIX}/usr/lib                  *"
echo "*     export PATH:$PATH:$HOME/${PREFIX}/usr/bin                       *"
echo "*                                                                     *"
echo "* Next you can either log out and back in or source the proper file   *"
echo "* from above.                                                         *"
echo "*                                                                     *"
echo "***********************************************************************"
exit 0
