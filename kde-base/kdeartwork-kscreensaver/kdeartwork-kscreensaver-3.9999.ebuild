# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdeartwork"
EAPI="4"
inherit trinity-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS=""
IUSE="opengl xscreensaver arts"

DEPEND="
	>=kde-base/kscreensaver-${PV}:${SLOT}
	>=kde-base/krootbacking-${PV}:${SLOT}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )
	arts? ( kde-base/arts )"
RDEPEND="$DEPEND"

src_configure() {
	mycmakeargs=(
		-DWITH_LIBART=ON
		$(cmake-utils_use_with opengl OPENGL)
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
