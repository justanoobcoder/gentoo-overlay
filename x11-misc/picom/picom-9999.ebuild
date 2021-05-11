# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
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
KEYWORDS="~amd64"
IUSE=""
 
DEPEND="x11-libs/libX11
        x11-misc/xcb
        x11-libs/libxcb
        x11-libs/libXext
        x11-base/xcb-proto
        x11-libs/libXdamage
        x11-libs/libXfixes
        x11-libs/xcb-util-renderutil
        x11-libs/libXrender
        x11-libs/libXcomposite
        dev-libs/libconfig
        x11-libs/pixman
        dev-libs/libev
        media-libs/libglvnd
        x11-libs/xcb-util-image
        x11-themes/hicolor-icon-theme"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/meson
        dev-util/ninja
        dev-libs/uthash
        app-text/asciidoc"

src_install() {
    meson --buildtype=release . build
    ninja -C build
    ninja -C build install
}
