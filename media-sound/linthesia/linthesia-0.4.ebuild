# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
inherit flag-o-matic
DESCRIPTION="Fork of Synthesia to GNU/Linux. Synthesia is a software which teaches you to play piano using piano-roll-style falling notes with any MIDI file, available under Windows and Mac. "
RESTRICT="mirror"
HOMEPAGE="https://sourceforge.net/projects/linthesia/"
LICENSE="GPLv2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
SRC_URI="https://sourceforge.net/projects/$PN/files/v0.4/linthesia-0.4-2.src.tgz/download -> linthesia-0.4.src.tgz"
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
append-flags -std=c++11 -std=gnu++11
default
}
S="$WORKDIR/$PN"
