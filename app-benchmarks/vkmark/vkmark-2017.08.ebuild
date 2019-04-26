# Copyright Gentoo Foundation
# Public domain

EAPI=6
inherit meson ninja-utils

DESCRIPTION="Vulkan benchmark"
HOMEPAGE="https://github.com/vkmark/vkmark"

RESTRICT="mirror"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wayland +kms +xcb"

SRC_URI="$HOMEPAGE/archive/$PV.tar.gz"

DEPEND="dev-util/meson
dev-util/ninja
media-libs/mesa"
RDEPEND="${PYTHON_DEPS}
media-libs/vulkan-loader
media-libs/glm
media-libs/assimp
x11-libs/libdrm
x11-libs/libxcb
wayland? (
dev-libs/wayland
)"

meson_src_configure(){
meson $(meson_use wayland) $(meson_use kms) $(meson_use xcb) build
}
meson_src_compile(){
eninja -C build
}
meson_src_install(){
DESTDIR=$D eninja -C build install
dosym /usr/local/bin/vkmark /usr/bin/vkmark
}
