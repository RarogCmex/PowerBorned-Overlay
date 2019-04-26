# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
DESCRIPTION="Free sf2 collections of various banks and samples from musicworker.ru, which includes own musicworker's soundfonts.Use bindist for install ONLY maked by musicworker.ru soundfonts"
RESTRICT="mirror fetch"
HOMEPAGE="http://musicworker.ru/banks_and_samples/nebolshaya-podborka-sf2-bankov-naletay/"
LICENSE="Unknown_Free"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="-bindist"
SRC_URI="$DISTDIR/$PN.tar.gz"

DEPEND=""
RDEPEND="${DEPEND}"
DOCS="info.txt"
S="${WORKDIR}"

src_install(){
cd $D
mkdir -p usr/share/sounds/sf2/$PN/
if use bindist; then cp -a $WORKDIR/'My Banks'/* usr/share/sounds/sf2/$PN/
cp $WORKDIR/info.txt usr/share/sounds/sf2/$PN/
else
cp -a $WORKDIR/* usr/share/sounds/sf2/$PN/
fi
}
