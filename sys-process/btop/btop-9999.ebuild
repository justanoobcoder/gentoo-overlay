# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A resource monitor written in C++"
HOMEPAGE="https://github.com/aristocratos/btop"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/aristocratos/btop.git"
else
    SRC_URI="https://github.com/aristocratos/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="+suid"

src_install() {
    make PREFIX=${D}/usr install
    if use suid; then
        make PREFIX=${D}/usr setuid
    fi
}
