 
# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit python-any-r1 waf-utils

DESCRIPTION="A Linux Guitar Amplifier for jack audio connection kit"
HOMEPAGE="http://guitarix.sourceforge.net/ http://guitarix.org/"
SRC_URI="mirror://sourceforge/guitarix/guitarix/${P}.tar.xz"

S="${WORKDIR}/guitarix-${PV}"
KEYWORDS="~amd64 ~x86"
SLOT="2"
LICENSE="GPL-2"


# Enabling LADSPA is discouraged by the developer
# See https://linuxmusicians.com/viewtopic.php?p=88153#p88153
IUSE="+standalone +lv2 avahi bluetooth nls capture meterbridge -faust -debug"

RDEPEND="media-libs/libsndfile
	x11-libs/gtk+:2
	virtual/jack
	dev-cpp/gtkmm:2.4
	dev-libs/boost
	dev-cpp/eigen:3
	sci-libs/fftw:3.0
    media-sound/lame
	>=media-libs/zita-convolver-3
	media-libs/zita-resampler
	standalone? (
		media-libs/lilv
		media-libs/liblrdf
		media-fonts/roboto
	)
	lv2? ( media-libs/lv2 )
	avahi? ( net-dns/avahi )
	faust? ( dev-lang/faust )
	bluetooth? ( net-wireless/bluez )
	meterbridge? ( media-sound/meterbridge )
	capture? ( media-sound/jack_capture )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( dev-util/intltool )"

DOCS=( changelog README )

src_configure() {
	local mywafconfargs=(
		--cxxflags-release="-DNDEBUG"
		--nocache
		--shared-lib
		--lib-dev
		--no-ldconfig
		--no-desktop-update
		$(usex debug --debug "")
		$(usex lv2 --lv2dir="${EPREFIX}"/usr/$(get_libdir)/lv2 --no-lv2)
		$(usex faust "--faust" "--no-faust")
		$(usex standalone "" "--no-standalone")
		$(usex avahi "" "--no-avahi")
		$(usex bluetooth "" "--no-bluez")
		$(use_enable nls)
	)
	waf-utils_src_configure ${mywafconfargs[@]}
}
