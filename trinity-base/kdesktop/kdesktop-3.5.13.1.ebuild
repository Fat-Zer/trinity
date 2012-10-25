# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta
TSM_EXTRACT_ALSO="kcheckpass"

DESCRIPTION="KDesktop is the Trinity interface that handles the icons, desktop popup menus and screensaver system."
KEYWORDS="x86 amd64"
IUSE="pam xscreensaver"

DEPEND="x11-libs/libXext
	x11-libs/libXcursor
	trinity-base/libkonq:${SLOT}
	>=trinity-base/kcontrol-${PV}:${SLOT}
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	>=trinity-base/kcheckpass-${PV}:${SLOT}
	>=trinity-base/kdialog-${PV}:${SLOT}
	>=trinity-base/konqueror-${PV}:${SLOT}
	xscreensaver? ( x11-libs/libXScrnSaver )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-meta_src_configure
}
