# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..2} luajit )
inherit lua-single

DESCRIPTION="Vim-fork focused on extensibility and agility."
HOMEPAGE="https://neovim.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/nightly.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="amd64 ~arm ~arm64 x86 ~x64-macos"
LICENSE="Apache-2.0 vim"
SLOT="0"
IUSE="+lto +nvimpager +tui"
REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}
        dev-lua/luv[${LUA_SINGLE_USEDEP}]
	    $(lua_gen_cond_dep '
            dev-lua/lpeg[${LUA_USEDEP}]
            dev-lua/mpack[${LUA_USEDEP}]
	    ')
	    $(lua_gen_cond_dep '
            dev-lua/LuaBitOp[${LUA_USEDEP}]
	    ' lua5-{1,2})
        dev-libs/libutf8proc
        dev-libs/libuv
        dev-lang/luajit
        dev-libs/msgpack
        dev-libs/libvterm
        tui? (
            dev-libs/unibilium
            dev-libs/libtermkey
        )"
RDEPEND="${DEPEND}
        app-eselect/eselect-vi
        dev-libs/tree-sitter
        x11-misc/xclip"
BDEPEND="${LUA_DEPS}
        virtual/libiconv
        virtual/libintl
        virtual/pkgconfig
        dev-util/gperf"

src_compile() {
	cmake -S"${S}" -Bbuild -GNinja \
	        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
			-DCMAKE_INSTALL_PREFIX=/usr
	cmake --build build
}

src_install() {
	DESTDIR="${D}" cmake --build . --target install || die "install failed"
	install -Dm644 LICENSE "${D}/usr/share/licenses/${D}/LICENSE"
	install -Dm644 runtime/nvim.desktop "${D}/usr/share/applications/nvim.desktop"
	install -Dm644 runtime/nvim.png "${D}/usr/share/pixmaps/nvim.png"
}
