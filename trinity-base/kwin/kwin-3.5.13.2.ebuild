# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta eutils

DESCRIPTION="Trinity window manager"
KEYWORDS="x86 amd64"
IUSE="xcomposite"

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
		$(cmake-utils_use_with xcomposite XFIXES)
		$(cmake-utils_use_with xcomposite XRENDER)
		$(cmake-utils_use_with xcomposite XDAMAGE)
		$(cmake-utils_use_with xcomposite XEXT)
	)

	trinity-meta_src_configure
}
