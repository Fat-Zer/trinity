# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta

DESCRIPTION="Various plugins for Konqueror."
KEYWORDS=""
IUSE+="arts"
DEPEND=">=trinity-base/konqueror-${PV}:${SLOT}
	arts? ( >=trinity-base/arts-${PV}:${SLOT} )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		"-DWITH_ARTS=$(usex arts)"
	)

	trinity-meta_src_configure
}
