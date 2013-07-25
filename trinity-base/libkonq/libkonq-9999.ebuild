# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=
IUSE="arts"
DEPEND="arts? ( >=trinity-base/arts-${PV}:${SLOT} )"
RDEPEND="$DEPEND"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
