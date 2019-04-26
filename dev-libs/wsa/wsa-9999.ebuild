# Copyright Gentoo Foundation
# Public domain

EAPI=6
MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit multilib-minimal git-r3

DESCRIPTION="The Window System Agent (WSA) library is introduced to encapsulte details about the native window system. It provides some general interfaces for driver to interact with different window systems. Driver could dynamically load WSA library according to the window system that application is running on. Currently, only Wayland is supported. 
"
HOMEPAGE="https://github.com/GPUOpen-Drivers/wsa"

LICENSE="MIT"
SLOT="9999"
KEYWORDS="~amd64 ~x86"
IUSE=""
EGIT_REPO_URI="https://github.com/GPUOpen-Drivers/wsa"
DEPEND="dev-util/cmake"
RDEPEND="dev-libs/wayland[${MULTILIB_USEDEP}]"



multilib_src_configure() {
    local myconf=()
	cd "${S}"
	if use abi_x86_64 && multilib_is_native_abi
	then myconf+=( -Bbuilds/Release64 )
	else 
	myconf+=( -Bbuilds/Release -DCMAKE_C_FLAGS=-m32 )
    fi
    cmake -H. "${myconf[@]}"
}

multilib_src_compile() {
	if use abi_x86_64 && multilib_is_native_abi
    then BUILD_DIR="${S}/builds/Release64"
    else BUILD_DIR="${S}/builds/Release"
    fi
	cd ${BUILD_DIR}
	emake
}

multilib_src_install() {
	if use abi_x86_64 && multilib_is_native_abi
	then BUILD_DIR="${S}/builds/Release64"  
	mkdir -p ${D}/usr/lib64/
	mv "${BUILD_DIR}/wayland/libamdgpu_wsa_wayland.so" ${D}/usr/lib64/
	else BUILD_DIR="${S}/builds/Release"
	mkdir -p ${D}/usr/lib32/
	mv "${BUILD_DIR}/wayland/libamdgpu_wsa_wayland.so" ${D}/usr/lib32/
	fi
}
