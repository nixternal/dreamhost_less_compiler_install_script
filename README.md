Dreamhost Shared Server LESS CSS Compiler Installation Script
=============================================================
This script downloads and installs everything necessary in order to use the
LESS CSS compiler on a Dreamhost Shared Server.

Getting
-------
You can either use git to clone this repository, or wget just to download the
script:

    $> git clone git://github.com/nixternal/dreamhost_less_compiler_install_script.git

or

    $> wget fill this in

Usage
-----
It doesn't get any easier than the following:

    $> ./dh_less_inst.sh

Script Process
--------------
This is exactly what the script does:

* Clones LESS CSS from github, moves bin/lessc & lib/less to ${PREFIX} set in
  the script. Default is $HOME/.local/usr
* Downloads the following 64-bit packages from the Ubuntu archives, extracts
  them, and moves them to their proper locations in $HOME/.local/usr:
  * nodejs
  * libc-ares2
  * libssl1.0.0
  * libicu
  * libv8
* Downloads the libev4 tarball, extracts it, builds & installs

All library files are placed by default in $HOME/.local/usr/lib and lessc and
nodjs executables get placed in $HOME/.local/usr/bin. I didn't move man pages
and what not, because if you are using this script, I am sure you already know
how to use lessc. Node.js is only functional for the LESS Compiler. Don't try
and run Node.js projects, because if you do, Dreamhost will kill your contract.
Use this stuff responsibly please.

Meta
----
* Homepage: http://www.nixternal.com/
* Twitter: [@nixternal](http://www.twitter.com/nixternal)

License
-------
(The GNU General Public License)

Copyright &copy; 2011 Richard A. Johnson &lt;nixternal@gmail.com&gt;

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
