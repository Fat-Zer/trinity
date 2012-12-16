# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="applications"
TRINITY_MODULE_VER="3.5.13.1"

inherit trinity-base

DESCRIPTION="A user friendly IRC Client for Trinity"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"

need-trinity 3.5.13

SLOT="${TRINITY_VER}"
IUSE="xscreensaver doc"

DEPEND="xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="$DEPEND"

PATCHES=( "${FILESDIR}/${PN}-${TRINITY_MODULE_VER}-initial-cmake.patch" )

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
		$(cmake-utils_use_build doc DOC)
		-DBUILD_ALL=ON
	)

	trinity-base_src_configure
}
