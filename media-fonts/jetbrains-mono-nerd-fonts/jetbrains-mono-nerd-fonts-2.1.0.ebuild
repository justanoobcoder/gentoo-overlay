# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="A Nerd Font patched version of JetBrains Mono."
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"

SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/JetBrainsMono.zip -> ${P}.zip"
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
 
DEPEND="media-libs/fontconfig"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    install -dm755 "${D}/usr/share/fonts/TTF"
    find . -iname "*.ttf" -not -iname "*Windows Compatible.ttf" -execdir install -m644 {} "${D}/usr/share/fonts/TTF/{}"
}
