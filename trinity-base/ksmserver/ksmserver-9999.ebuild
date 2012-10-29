# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The reliable Trinity session manager that talks the standard X11R6"
KEYWORDS=""
IUSE="hal upower"

DEPEND="
	>=dev-libs/dbus-tqt-${PV}
	hal? ( sys-apps/hal )"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with hal HAL )
		$(cmake-utils_use_with upower UPOWER )
	)

	trinity-meta_src_configure
}
