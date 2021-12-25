
# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit git-r3 cmake python-single-r1

MY_PN="polybar-dwm-module"
DESCRIPTION="Polybar with dwm module."
HOMEPAGE="https://github.com/mihirlad55/polybar-dwm-module"

EGIT_REPO_URI="https://github.com/mihirlad55/polybar-dwm-module"
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa curl doc i3wm +dwm +ipc mpd network pulseaudio"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
        ${PYTHON_DEPS}
        $(python_gen_cond_dep 'x11-base/xcb-proto[${PYTHON_USEDEP}]')
        x11-libs/cairo[X,xcb(+)]
        x11-libs/libxcb[xkb]
        x11-libs/xcb-util-image
        x11-libs/xcb-util-wm
        x11-libs/xcb-util-xrm
        alsa? ( media-libs/alsa-lib )
        curl? ( net-misc/curl )
        doc? ( dev-python/sphinx )
        i3wm? (
            dev-libs/jsoncpp:=
            || ( x11-wm/i3 x11-wm/i3-gaps )
        )
        mpd? ( media-libs/libmpdclient )
        network? ( net-wireless/wireless-tools )
        pulseaudio? ( media-sound/pulseaudio )
"

RDEPEND="${DEPEND}"

src_prepare() {
    git -C "${MY_PN}" submodule update --init --recursive
    
    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
    	-DENABLE_ALSA="$(usex alsa)"
    	-DENABLE_CURL="$(usex curl)"
    	-DBUILD_DOC="$(usex doc)"
    	-DENABLE_I3="$(usex i3wm)"
        -DENABLE_DWM="$(usex dwm)"
    	-DBUILD_IPC_MSG="$(usex ipc)"
    	-DENABLE_MPD="$(usex mpd)"
    	-DENABLE_NETWORK="$(usex network)"
    	-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
    )
    
    cmake_src_configure
}
