# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#XORG_MULTILIB=yes
#inherit xorg-3

DESCRIPTION="libXft with BGRA glyph (color emoji) rendering & scaling patches by Maxime Coste"

HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libxft"

SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxft/-/archive/master/libxft-master.tar.gz"
S="${WORKDIR}/libxft-master"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

#DEPEND="x11-base/xorg-proto"
#RDEPEND=">=media-libs/fontconfig-2.10.92[${MULTILIB_USEDEP}]
	#>=media-libs/freetype-2.5.0.1[${MULTILIB_USEDEP}]
	#virtual/ttf-fonts
	#>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	#>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	#>=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]"

src_prepare() {
    eapply -p1 <(curl -Ls https://gitlab.freedesktop.org/xorg/lib/libxft/merge_requests/1.patch)
    eapply_user
}

src_compile() {
    sh autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man || die "compile failed"
    make || die "make failed"
}

src_install() {
    make DESTDIR="${D}" install || die "make install failed"
    install -d -m755 "${D}/usr/share/licenses/${PN}"
    install -m644 COPYING "${D}/usr/share/licenses/${PN}/"
}
