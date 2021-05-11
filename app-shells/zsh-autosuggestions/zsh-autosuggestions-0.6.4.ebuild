# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="Fish-like fast/unobtrusive autosuggestions for zsh."
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zsh-users/zsh-autosuggestions.git"
else
	SRC_URI="https://github.com/zsh-users/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
 
RDEPEND="app-shells/zsh"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
at the end of your .zshrc file"

src_install() {
	#emake \
		#SHARE_DIR="${ED}/usr/share/zsh/site-functions" \
		#DOC_DIR="${ED}/usr/share/doc/${PF}" \
		#install
    install -vDm 644 ${PN}{,.plugin}.zsh \
    -t "${ED}/usr/share/zsh/site-functions/${PN}/"
    # docs
    install -vDm 644 {CHANGELOG,README}.md \
      -t "${ED}/usr/share/doc/${PN}/"
}
