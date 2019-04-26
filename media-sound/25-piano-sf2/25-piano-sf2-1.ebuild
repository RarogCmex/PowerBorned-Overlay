# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
DESCRIPTION="Free sf2 archive with 25 piano voices. Not only for fl studio"
RESTRICT="mirror fetch"
HOMEPAGE="https://www.flstudiomusic.com/2010/02/25-piano-soundfonts.html
http://flstudiomania.blogspot.com/"
LICENSE="Unknown_Free"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
SRC_URI="$DISTDIR/$PN.tar.gz"

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}"
src_install(){
cd $D
mkdir -p usr/share/sounds/sf2/
cp -a $WORKDIR/* usr/share/sounds/sf2/
}
