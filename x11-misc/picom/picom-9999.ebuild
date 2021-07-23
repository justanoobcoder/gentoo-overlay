# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit meson python-any-r1 virtualx xdg

DESCRIPTION="Jonaburg's picom fork with tryone144's dual_kawase blur and Ibhagwan's rounded corners, an X compositor (compton's fork)"
HOMEPAGE="https://github.com/jonaburg/picom"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jonaburg/picom"
else
	SRC_URI="https://github.com/jonaburg/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x84"
IUSE="+config-file dbus +doc +drm opengl pcre test"

REQUIRED_USE="test? ( dbus )" # avoid "DBus support not compiled in!"
RESTRICT="test" # but tests require dbus_next
 
RDEPEND="x11-libs/libX11
        dev-libs/uthash
        x11-misc/xcb
        x11-libs/libxcb
        x11-libs/libXext
        x11-base/xcb-proto
        x11-libs/libXdamage
        x11-libs/libXfixes
        x11-libs/xcb-util-renderutil
        config-file? (
            dev-libs/libconfig:=
        )
        dbus? ( sys-apps/dbus )
        drm? ( x11-libs/libdrm )
        opengl? ( virtual/opengl )
        pcre? ( dev-libs/libpcre )
        x11-libs/libXrender
        x11-libs/libXcomposite
        x11-libs/pixman
        dev-libs/libev
        media-libs/libglvnd
        x11-libs/xcb-util-image
        x11-themes/hicolor-icon-theme
        !x11-misc/compton
"
DEPEND="${RDEPEND}
        x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig
        dev-util/meson
        dev-util/ninja
	doc? ( app-text/asciidoc )
	test? ( $(python_gen_any_dep 'dev-python/xcffib[${PYTHON_USEDEP}]') )
"

src_compile() {
    meson --buildtype=release . build --prefix=/usr -Dwith_docs=true || die "meson build failed"
    ninja -C build || die "ninja build failed"
}

src_install() {
    DESTDIR=${D} ninja -C build install || die "ninja build install failed"
}
