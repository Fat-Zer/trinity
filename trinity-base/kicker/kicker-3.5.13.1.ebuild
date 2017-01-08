# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="The Trinity application starter panel, capable of applets and extensions"
KEYWORDS="x86 amd64"
IUSE="xcomposite"

DEPEND=">=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kdebase-data-${PV}:${SLOT}
	xcomposite? ( x11-libs/libXrender )
	xcomposite? ( x11-libs/libXfixes )
	xcomposite? ( x11-libs/libXcomposite )"

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
