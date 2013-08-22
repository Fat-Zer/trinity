# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdeutils"

inherit trinity-meta

DESCRIPTION="KLaptopdaemon - Trinity battery monitoring and management for laptops."
KEYWORDS=""
IUSE="xscreensaver"

DEPEND="x11-libs/libXtst
	xscreensaver? ( x11-libs/libXScrnSaver )
	virtual/os-headers"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		"-DWITH_DPMS=ON"
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-meta_src_configure
}
