# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
inherit git-r3
DESCRIPTION="Fork of Synthesia to GNU/Linux. Synthesia is a software which teaches you to play piano using piano-roll-style falling notes with any MIDI file, available under Windows and Mac. "
RESTRICT="mirror"
HOMEPAGE="https://sourceforge.net/projects/linthesia/ https://github.com/linthesia/linthesia/tree/master"
LICENSE="GPLv2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
SRC_URI=""
EGIT_REPO_URI="https://github.com/linthesia/linthesia.git"
DEPEND="
dev-cpp/gtkmm:2.4
dev-cpp/gconfmm
>=dev-cpp/gtkglextmm-1.2.0
media-libs/alsa-lib
dev-libs/libsigc++:2
dev-cpp/glibmm
"
RDEPEND="${DEPEND}"

src_configure(){
autoreconf -ivf
default
}
