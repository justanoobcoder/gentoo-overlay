# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="System clipboard key bindings for Zsh Line Editor with vi mode."
HOMEPAGE="https://github.com/kutsan/zsh-system-clipboard"

inherit git-r3
EGIT_REPO_URI="https://github.com/kutsan/zsh-system-clipboard"
 
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
 
RDEPEND="app-shells/zsh"

DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
at the end of your .zshrc file"

src_install() {
    install -vDm 644 ${PN}{,.plugin}.zsh -t "${ED}/usr/share/zsh/plugins/${PN}/"
    install -vDm 644 {CHANGELOG,README}.md -t "${ED}/usr/share/doc/${PN}/"
    install -vDm 644 LICENSE "${ED}/usr/share/licenses/${PN}/LICENSE"
}
