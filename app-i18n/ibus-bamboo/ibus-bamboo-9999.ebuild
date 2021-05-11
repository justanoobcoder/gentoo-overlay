# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="A Vietnamese IME for IBus"
HOMEPAGE="https://github.com/BambooEngine"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BambooEngine/ibus-bamboo.git"
else
	SRC_URI="https://github.com/BambooEngine/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
 
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${P}"
 
DEPEND="app-i18n/ibus"
RDEPEND="${DEPEND}
        x11-libs/libX11
        x11-libs/libXtst"
BDEPEND="sys-devel/make
        dev-lang/go"

src_install() {
    make DESTDIR=${D} install || die "make install failed!"
}
