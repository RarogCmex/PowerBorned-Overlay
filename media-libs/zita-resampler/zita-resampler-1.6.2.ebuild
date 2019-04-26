# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

RESTRICT="mirror"

SOURCE_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads"

DESCRIPTION="A C++ library for resampling audio signals. It is designed to be used within a real-time processing context, to be fast, and to provide high-quality sample rate conversion."
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/zita-resampler/resampler.html"
SRC_URI="${SOURCE_URI}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~ppc64 ~arm ~arm64 ~s390 ~amd64-fbsd"
IUSE="+tools"

RDEPEND="media-libs/libsndfile
media-libs/flac
media-libs/libogg
media-libs/libvorbis"
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

	if use tools; then
		pushd apps
		emake
		popd
	fi
}

src_install() {
	pushd source
	emake DESTDIR="${D}" PREFIX=/usr install
	popd
    mkdir -p $D/usr/bin/
    mkdir -p ${D}/usr/share/man/man1
	if use tools; then
		pushd apps
		emake DESTDIR="${D}" PREFIX=/usr install
		popd
	fi
	dosym libzita-resampler.so.1.6.2 /usr/lib64/libzita-resampler.so.1 
  	dodoc "${DOCS[@]}"

}
