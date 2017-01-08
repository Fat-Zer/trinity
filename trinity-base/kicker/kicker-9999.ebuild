# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The Trinity application starter panel, capable of applets and extensions"
KEYWORDS=
IUSE="xcomposite"

DEPEND=">=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/tdebase-data-${PV}:${SLOT}
	dev-libs/dbus-tqt
	xcomposite? ( x11-libs/libXrender
		x11-libs/libXfixes
		x11-libs/libXcomposite )"

RDEPEND="${DEPEND}
	trinity-base/kmenuedit:${SLOT}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XFIXES)
		$(cmake-utils_use_with xcomposite XRENDER)
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
	)

	trinity-meta_src_configure
}
