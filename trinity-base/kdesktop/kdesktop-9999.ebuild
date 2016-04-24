# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="KDesktop is the Trinity interface that handles icons, desktop popup menus and screensaver system."
KEYWORDS=
IUSE="pam xscreensaver"

COMMON_DEPEND="x11-libs/libXrender
	x11-libs/libXcursor
	>=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kcontrol-${PV}:${SLOT}
	xscreensaver? ( x11-libs/libXScrnSaver )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
DEPEND="${COMMON_DEPEND}
	xscreensaver? ( x11-proto/scrnsaverproto )
	xscreensaver? ( x11-misc/xscreensaver )"
# TODO remove x11-misc/xscreensaver after TDE bug # will be fixed
RDEPEND="${COMMON_DEPEND}
	>=trinity-base/kcheckpass-${PV}:${SLOT}
	>=trinity-base/kdialog-${PV}:${SLOT}
	>=trinity-base/konqueror-${PV}:${SLOT}
	pam? ( trinity-base/kdebase-pam )"

TSM_EXTRACT_ALSO="kcheckpass/"

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSORS=ON
		-DWITH_XRENDER=ON
		$(cmake-utils_use_with pam PAM)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-meta_src_configure
}
