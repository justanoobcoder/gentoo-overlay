# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=7
 
DESCRIPTION="Canonical's on-screen-display notification agent."
HOMEPAGE="https://launchpad.net/notify-osd"

inherit git-r3
EGIT_REPO_URI="https://github.com/justanoobcoder/notify-osd.git"
 
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND=">=dev-libs/dbus-glib-0.98
	    >=dev-libs/glib-2.16:2
	    >=x11-libs/gtk+-3.2:3
	    >=x11-libs/libnotify-0.7
	    >=x11-libs/libwnck-3:3
	    x11-libs/libX11
	    x11-libs/pixman
	    !x11-misc/notification-daemon
	    !x11-misc/qtnotifydaemon"
RDEPEND="${DEPEND}
	    gnome-base/gsettings-desktop-schemas
	    !minimal? ( x11-themes/notify-osd-icons )"
BDEPEND="dev-util/glib-utils
	    gnome-base/gnome-common
	    x11-base/xorg-proto
	    virtual/pkgconfig"

src_install() {
    ./autogen.sh --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib/${PN} \
		--disable-static --disable-schemas-compile
    make
    make DESTDIR=${D} install || die "make install failed" 
}
