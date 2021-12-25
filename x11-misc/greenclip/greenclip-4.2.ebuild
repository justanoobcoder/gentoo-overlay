# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="Simple clipboard manager to be integrated with rofi."
HOMEPAGE="https://github.com/erebe/greenclip"

SRC_URI="https://github.com/erebe/${PN}/releases/download/v${PV}/${PN}"
KEYWORDS="~amd64"
 
LICENSE="BSD License"
SLOT="0"
IUSE="+rofi dmenu fzf"
REQUIRED_USE="?? ( dmenu fzf rofi )" 

RDEPEND="
        rofi? ( x11-misc/rofi )
        dmenu? ( x11-misc/dmenu )
        fzf? ( app-shells/fzf )
"
src_unpack() {
    mkdir -p ${S}
    cp "${DISTDIR}/${A}" "${S}" || die "cp failed"
}

src_install() {
    dobin ${A}
}

pkg_postinst() {
    ewarn 'Run `greenclip daemon` to start clipboard daemon'
    elog "For more information about greenclip, please visit ${HOMEPAGE}"
}
