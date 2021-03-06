# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pam toolchain-funcs

MY_PN=OpenDoas
MY_P=${MY_PN}-${PV}
DESCRIPTION="Run commands as super/another user (alt sudo) (unofficial port from OpenBSD)"
HOMEPAGE="https://github.com/justanoobcoder/OpenDoas"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/justanoobcoder/OpenDoas"
else
    SRC_URI="https://github.com/justanoobcoder/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
    S="${WORKDIR}"/${MY_P}
    KEYWORDS="amd64 arm arm64 ~hppa ~ia64 ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="pam persist"

BDEPEND="virtual/yacc"
RDEPEND="pam? ( sys-libs/pam )
	!pam? ( virtual/libcrypt:= )"
DEPEND="${RDEPEND}"

src_prepare() {
    default
    sed -i 's/-Werror //' GNUmakefile || die
}

src_configure() {
    tc-export CC AR
    
    ./configure \
    	--prefix="${EPREFIX}"/usr \
    	--sysconfdir="${EPREFIX}"/etc \
    	$(use_with pam) \
    	$(use_with persist timestamp) \
    || die "Configure failed"
}

src_install() {
    default
    if use pam; then
    	pamd_mimic system-auth doas auth account session
    fi
}

pkg_postinst() {
    if use persist ; then
    	ewarn "The persist/timestamp feature is disabled by default upstream."
    	ewarn "It may not be as secure as on OpenBSD where proper kernel support exists."
    fi
    
    if [[ -z "${REPLACING_VERSIONS}" ]] ; then
    	elog "By default, doas will deny all actions."
    	elog "You need to create your own custom configuration at ${EROOT}/etc/doas.conf."
        elog "See https://wiki.gentoo.org/wiki/Doas for guidance."
    fi
}
