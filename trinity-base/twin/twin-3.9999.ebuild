# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"
# TRINITY_SUBMODULES="twin xrender xfiles xext"

inherit trinity-meta eutils

# TSM_EXTRACT="twin"

DESCRIPTION="Trinity window manager"
KEYWORDS=""
IUSE="xcomposite"

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
	# 					 x11-libs/libXdamage )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_KWIN=ON
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
		$(cmake-utils_use_with xcomposite XFIXES)
		$(cmake-utils_use_with xcomposite XRENDER)
		$(cmake-utils_use_with xcomposite XDAMAGE)
		$(cmake-utils_use_with xcomposite XEXT)
	)

	trinity-base_src_configure
#TODO: change this after upstream BUG #1284 become fixed
#	trinity-meta_src_configure
}
