# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="2"
inherit trinity-meta

DESCRIPTION="Kicker is the KDE application starter panel, also capable of some useful applets and extensions."
KEYWORDS=""
IUSE="xcomposite"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	x11-libs/libXrender
	x11-libs/libXfixes
	xcomposite? ( x11-libs/libXcomposite )"

RDEPEND="${RDEPEND}
	kde-base/kmenuedit:${SLOT}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
	)

	trinity-meta_src_configure
}
