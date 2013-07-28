# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="The reliable Trinity session manager that talks the standard X11R6"
KEYWORDS="~amd64 ~x86"
IUSE="hal"

DEPEND="
	dev-libs/dbus-tqt
	hal? ( sys-apps/hal )"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with hal HAL )
	)

	trinity-meta_src_configure
}
