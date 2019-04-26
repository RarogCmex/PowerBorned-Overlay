# Copyright Gentoo Foundation
# Public domain

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )
inherit python-any-r1

DESCRIPTION="AMD Open Source Driver for Vulkan"
HOMEPAGE="https://github.com/GPUOpen-Drivers/AMDVLK"



LICENSE="MIT"
SLOT="9999"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake 
dev-util/repo"
RDEPEND="${PYTHON_DEPS}
x11-libs/libdrm
x11-libs/libXrandr
virtual/libstdc++
x11-libs/libxcb
x11-libs/libxshmfence
dev-util/vulkan-headers
media-libs/vulkan-loader
net-misc/curl"

src_unpack() {
	mkdir ${S}
	cd ${S}
	repo init -u https://github.com/GPUOpen-Drivers/AMDVLK.git -b master
	repo sync
}


BUILD_DIR="${S}/drivers/xgl/builds/Release64"
src_prepare(){
	cat << EOF > "${T}/10-amdvlk-dri3.conf" || die
Section "Device"
Identifier "AMDgpu"
Option  "DRI" "3"
EndSection
EOF
default
}

src_configure() {
	cd "${S}/drivers/xgl"
	cmake -H. -Bbuilds/Release64
}

src_compile() {
	cd ${BUILD_DIR}
	make
}

src_install() {
	dolib.so "${BUILD_DIR}/icd/amdvlk64.so"

	insinto /etc/vulkan/icd.d
	doins ${S}/drivers/AMDVLK/json/Redhat/amd_icd64.json
	insinto /usr/share/X11/xorg.conf.d/
	doins ${T}/10-amdvlk-dri3.conf
}

pkg_postinst() {
        elog "More information about the configuration can be found here:"
        elog "  https://github.com/GPUOpen-Drivers/AMDVLK"
        elog "And make sure following line is NOT included in the section: "
        elog "Driver      \"modesetting\""
}


