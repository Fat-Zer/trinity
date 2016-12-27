# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegames"

inherit trinity-meta

DESCRIPTION="Trinity Space Game"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-base/libtdegames-${PV}:${SLOT}
	>=trinity-base/arts-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_ARTS=ON
	)

	trinity-meta_src_configure
}
