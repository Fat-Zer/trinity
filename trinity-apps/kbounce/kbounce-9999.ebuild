# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegames"

inherit trinity-meta

DESCRIPTION="Trinity Bounce Ball Game"
KEYWORDS=""
IUSE+="+arts"
DEPEND=">=trinity-base/libtdegames-${PV}:${SLOT}
	arts? ( >=trinity-base/arts-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
