# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="x86 amd64"
IUSE="arts"
DEPEND="arts? ( >=trinity-base/arts-${PV}:${SLOT} )"
RDEPEND="$DEPEND"
PATCHES=( "$FILESDIR/${PN}-3.5.13.1-onlyshowin-tde.patch")

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
