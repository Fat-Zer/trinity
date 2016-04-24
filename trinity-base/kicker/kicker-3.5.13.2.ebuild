# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Kicker is the Trinity application starter panel, also capable of some useful applets and extensions."
KEYWORDS="~amd64 ~x86"
IUSE="hal xcomposite"

DEPEND=">=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kdebase-data-${PV}:${SLOT}
	xcomposite? ( x11-libs/libXrender
		x11-libs/libXfixes
		x11-libs/libXcomposite )"

RDEPEND="${DEPEND}
	trinity-base/kmenuedit:${SLOT}"

PATCHES=( "$FILESDIR/${PN}-3.5.13.2-include-dbus.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XFIXES)
		$(cmake-utils_use_with xcomposite XRENDER)
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
		$(cmake-utils_use_with hal HAL)
	)

	trinity-meta_src_configure
}
