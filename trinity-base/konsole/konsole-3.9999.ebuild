# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="X terminal for use with Trinity."
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXrender"

RDEPEND="${DEPEND}
	x11-apps/bdftopcf
	>=trinity-base/kcontrol-${PV}:${SLOT}"

src_configure() {
	mycmakeargs=(
		-DWITH_XRENDER=ON
	)

	trinity-meta_src_configure
}
