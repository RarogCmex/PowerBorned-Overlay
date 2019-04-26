# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

RESTRICT="mirror"

SOURCE_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads"

DESCRIPTION="Zita-ajbridge provides zita-a2j and zita-j2a. They allow to use an ALSA device as a Jack client, to provide additional capture (a2j) or playback (j2a) channels. Functionally these are equivalent to the alsa_in and alsa_out clients that come with Jack, but they provide much better audio quality"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio/zita-ajbridge-doc/quickguide.html"
SRC_URI="${SOURCE_URI}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~ppc64 ~arm ~arm64 ~s390 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/alsa-lib
>=media-libs/zita-alsa-pcmi-0.3.0
>=media-libs/zita-resampler-1.6.0
virtual/jack"
DEPEND="${RDEPEND}"
DOCS=( AUTHORS COPYING README )


src_prepare() {
	default

	sed -i -e "/ldconfig/d" source/Makefile || die
	
}

src_compile() {
	pushd source
	emake
	popd
}

src_install() {
	mkdir -p ${D}/usr/{bin,share/man/man1}
	pushd source
	emake DESTDIR="${D}" PREFIX=/usr install
	popd
	#dosym libzita-resampler.so.1.6.2 /usr/lib64/libzita-resampler.so.1 
	dodoc "${DOCS[@]}"

}
