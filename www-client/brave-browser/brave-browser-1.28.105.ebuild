# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
CHROMIUM_LANGS="
	af am ar be bg bn ca cs da de de-CH el en-GB en-US eo es es-419 es-PE et eu
	fa fi fil fr fy gd gl gu he hi hr hu hy id io is it ja jbo ka kn ko ku lt
	lv mk ml mr ms nb nl nn pl pt-BR pt-PT ro ru sc sk sl sq sr sv sw ta te th
	tr uk vi zh-CN zh-TW
"
inherit chromium-2 multilib unpacker toolchain-funcs xdg-utils


DESCRIPTION="Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com/"
BRAVE_PN="${PN//-browser}"
BRAVE_BIN="${PN}"

case "${PN}" in
	brave-browser)
		BRAVE_BRANCH="${PN}-stable"
		res=(16 24 32 48 64 128 256)
		;;
	brave-browser-nightly)
		BRAVE_BRANCH="${PN}"
		res=(128)
		IMGPREFIX="_nightly"
		;;
	brave-browser-beta)
		BRAVE_BRANCH="${PN}"
		res=(128)
		IMGPREFIX="_beta"
		;;
esac

BRAVE_HOME="opt/brave.com/${BRAVE_PN}"
SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/${PN}_${PV}_amd64.deb"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

DEPEND="
	virtual/libiconv
"
RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/speex
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango[X]
"
QA_PREBUILT="*"
S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	iconv -c -t UTF-8 usr/share/applications/${PN}.desktop > "${T}"/${BRAVE_PN}.desktop || die
	mv "${T}"/${BRAVE_PN}.desktop usr/share/applications/${PN}.desktop || die

	mv usr/share/doc/${PN} usr/share/doc/${PF} || die
	chmod 0755 usr/share/doc/${PF} || die

	gunzip usr/share/doc/${PF}/changelog.gz || die
	gunzip usr/share/man/man1/${BRAVE_BRANCH}.1.gz || die

	if [[ "${BRAVE_BRANCH}" == *"stable"* ]]
	then
		rm usr/share/man/man1/${PN}.1.gz || die
	fi

	rm \
		etc/cron.daily/${BRAVE_BIN} \
		|| die
	rmdir \
		etc/cron.daily/ \
		etc/ \
		|| die

	local c d
	for d in ${res[*]}; do
		mkdir -p usr/share/icons/hicolor/${d}x${d}/apps || die
		cp \
			${BRAVE_HOME}/product_logo_${d}${IMGPREFIX}.png \
			usr/share/icons/hicolor/${d}x${d}/apps/${PN}.png || die
	done

	pushd "${BRAVE_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	eapply_user
}

src_install() {
	rm -r usr/share/appdata || die
	mv * "${D}" || die
	dosym /${BRAVE_HOME}/${PN} /usr/bin/${PN}

	fperms 4711 /${BRAVE_HOME}/chrome-sandbox
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
