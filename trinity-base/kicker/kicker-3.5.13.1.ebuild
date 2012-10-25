# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Kicker is the Trinity application starter panel, also capable of some useful applets and extensions."
KEYWORDS="x86 amd64"
IUSE="xcomposite"

DEPEND=">=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kdebase-data-${PV}:${SLOT}
	x11-libs/libXrender
	x11-libs/libXfixes
	xcomposite? ( x11-libs/libXcomposite )"

RDEPEND="${RDEPEND}
	trinity-base/kmenuedit:${SLOT}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
	)

	trinity-meta_src_configure
}
