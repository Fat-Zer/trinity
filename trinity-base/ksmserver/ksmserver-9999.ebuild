# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The reliable Trinity session manager that talks the standard X11R6"
KEYWORDS=
IUSE="hal upower"

DEPEND="
	dev-libs/dbus-tqt
	upower? ( dev-libs/dbus-1-tqt )
	hal? ( sys-apps/hal ) "

RDEPEND="${RDEPEND}
	upower? ( sys-power/upower ) "

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with hal HAL )
		$(cmake-utils_use_with upower UPOWER )
	)

	trinity-meta_src_configure
}
