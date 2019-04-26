# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7
inherit multilib

RESTRICT="mirror"

SOURCE_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads"

DESCRIPTION="Provides easy access to ALSA PCM devices"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="${SOURCE_URI}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~ppc64 ~arm ~arm64 ~s390 ~amd64-fbsd"
IUSE="+tools"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS COPYING README )


src_prepare() {
	default

	sed -i -e "/ldconfig/d" source/Makefile || die
	
}

src_compile() {
	pushd source
	emake PREFIX="${EPREFIX}/usr"
	popd

	if use tools; then
		pushd apps
		cp -ap $S/source/* .
		emake PREFIX="${EPREFIX}/usr" 
		popd
	fi
}

src_install() {
	pushd source
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
	popd

	if use tools; then
		pushd apps
		mkdir -p ${D}/usr/share/man/man1
		emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
		popd
	fi
	dosym libzita-alsa-pcmi.so.0.3.2 /usr/lib64/libzita-alsa-pcmi.so.0
	dodoc "${DOCS[@]}"

}
