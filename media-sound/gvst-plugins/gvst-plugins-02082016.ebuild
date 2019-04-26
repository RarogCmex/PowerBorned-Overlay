# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
DESCRIPTION="GVST is free effects and instrument sets.For the main part they are designed to be simple, light-weight and efficient, although some are more ambitious and some more experimental."
RESTRICT="mirror fetch"
HOMEPAGE="https://www.gvst.co.uk/index.htm"
LICENSE="GVSTLicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="abi_x86_64 bindist"
if use bindist; then
RESTRICT="mirror fetch"
fi
if use abi_x86_64 then 
SRC_URI="/usr/portage/distfiles/gvst-plugins.tar.gz"
else 
SRC_URI=""
fi
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"
src_install(){
cd $D
mkdir -p usr/lib/vst/
cp -ap $WORKDIR/$PN/* usr/lib/vst/
}
