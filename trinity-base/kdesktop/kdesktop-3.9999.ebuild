# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME=kdebase
EAPI="3"
inherit trinity-meta
KMEXTRACTALSO="kcheckpass"

DESCRIPTION="KDesktop is the KDE interface that handles the icons, desktop popup menus and screensaver system."
KEYWORDS=""
IUSE="pam xscreensaver"

DEPEND="x11-libs/libXext
	x11-libs/libXcursor
	kde-base/libkonq:${SLOT}
	kde-base/kcontrol:${SLOT}
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	kde-base/kcheckpass:${SLOT}
	kde-base/kdialog:${SLOT}
	kde-base/konqueror:${SLOT}
	xscreensaver? ( x11-libs/libXScrnSaver )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-meta_src_configure
}
