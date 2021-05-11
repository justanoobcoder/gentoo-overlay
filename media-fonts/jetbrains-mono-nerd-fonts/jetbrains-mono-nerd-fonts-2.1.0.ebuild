# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
#inherit unpacker

DESCRIPTION="A Nerd Font patched version of JetBrains Mono."
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"

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
    mkdir ${WORKDIR}/${P}
    unpack ${A}
}

src_install() {
    #install -dm755 /usr/share/fonts/TTF
    #find . -iname "*.ttf" -not -iname "*Windows Compatible.ttf" -execdir cp ./* "${D}/usr/share/fonts/TTF/"
    cp ${WORKDIR}/* /usr/share/fonts/TTF -rf
}
