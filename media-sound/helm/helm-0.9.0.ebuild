# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils

DESCRIPTION="Open source polyphonic software synthesizer with lots of modulation"
HOMEPAGE="http://tytel.org/helm/"
SRC_URI="https://github.com/mtytel/helm/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ CC-AT-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

RDEPEND="media-libs/alsa-lib
	media-libs/freetype
	media-libs/lv2
	virtual/jack
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}"

#DOCS="README.md"

src_compile() {
	emake PREFIX=/usr all
}

