# Copyright Gentoo Foundation
# Public domain. Ebuild made by Reva Denis aka RarogCmex.

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )
inherit python-any-r1 unpacker git-r3

DESCRIPTION="AMD Open Source Driver for Vulkan"
HOMEPAGE="https://github.com/GPUOpen-Drivers/AMDVLK"

CORRECT_PV="$(ver_rs 1 '.Q')" ||die "failed transform version"
#Transforming version 2019.2.2 to v-2019.Q2.2 to simplify ebuild update
#Don't forget to update params if you have difficultes

SRC_URI="$HOMEPAGE/releases/download/v-${CORRECT_PV}/amdvlk_${CORRECT_PV}_amd64.deb"
EGIT_REPO_URI="$HOMEPAGE"
#EGIT_CHECKOUT_DIR="${S}/AMDVLK-git"
RESTRICT="mirror"

QA_PRESTRIPPED="usr/lib64/*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="+spvgen"
#SPVGEN https://github.com/GPUOpen-Drivers/spvgen
DEPEND="dev-util/vulkan-headers"
RDEPEND="${PYTHON_DEPS}
x11-libs/libdrm
x11-libs/libXrandr
virtual/libstdc++
x11-libs/libxcb
x11-libs/libxshmfence
dev-util/vulkan-headers
media-libs/vulkan-loader
net-misc/curl
!media-libs/amdvlk
"
src_unpack(){
        unpack_deb ${A}
        git-r3_fetch $EGIT_REPO_URI "v-${CORRECT_PV}"
        git-r3_checkout
}
src_prepare(){
	cat << EOF > "${T}/10-amdvlk-dri3.conf" || die
Section "Device"
Identifier "AMDgpu"
Option  "DRI" "3"
EndSection
EOF
default
}

S=$WORKDIR
src_install(){ 
        insinto /usr/share/X11/xorg.conf.d/
	    doins ${T}/10-amdvlk-dri3.conf
	    exeinto /usr/lib64/
	    doexe ${WORKDIR}/usr/lib/x86_64-linux-gnu/amdvlk64.so || die "install failed!"
	    if use spvgen; then doexe ${WORKDIR}/usr/lib/x86_64-linux-gnu/spvgen.so ; fi
        insinto /usr/share/vulkan/icd.d
        doins ${WORKDIR}/${P}/json/Redhat/amd_icd64.json
} 



