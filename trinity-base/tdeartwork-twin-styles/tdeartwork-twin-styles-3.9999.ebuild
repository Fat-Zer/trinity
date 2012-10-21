# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_NAME="tdeartwork"

inherit trinity-meta
DESCRIPTION="Window styles for Trinity"
KEYWORDS=""
IUSE=""

DEPEND=">=trinity-base/twin-${PV}:${SLOT}"
RDEPEND="$DEPEND"

src_configure() {
	mycmakeargs=(
		-DBUILD_KWIN_STYLES=ON
	)

	trinity-base_src_configure
#TODO: change this after upstream BUG #1284 become fixed
#	trinity-meta_src_configure
}
