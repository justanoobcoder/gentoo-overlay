# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="A Nerd Font patched version of JetBrains Mono."
HOMEPAGE="https://www.nerdfonts.com"

_PAC_NAME="JetBrainsMono"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/${_PAC_NAME}.zip"
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
 
DEPEND="media-libs/fontconfig"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
    mkdir ${S}
    unzip ${DISTDIR}/${_PAC_NAME}.zip -d ${S}
}

src_install() {
    install -dm755 "${D}/usr/share/fonts/TTF"
    find ${S}/ -iname "*.ttf" -not -iname "*Windows Compatible.ttf" \
        -execdir install -m644 {} "${D}/usr/share/fonts/TTF/{}" \;
}
