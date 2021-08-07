# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="Friendly bindings for zsh's vim mode."
HOMEPAGE="https://github.com/softmoth/zsh-vim-mode"

inherit git-r3
EGIT_REPO_URI="https://github.com/softmoth/zsh-vim-mode"
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
 
RDEPEND="app-shells/zsh"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
source /usr/share/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh
at the end of your .zshrc file"

src_install() {
    install -vDm 644 ${PN}{,.plugin}.zsh -t "${ED}/usr/share/zsh/plugins/${PN}/"
    install -vDm 644 {CHANGELOG,README}.* -t "${ED}/usr/share/doc/${PN}/"
    install -vDm 644 LICENSE "${ED}/usr/share/licenses/${PN}/LICENSE"
}
