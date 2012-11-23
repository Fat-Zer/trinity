# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"
TRINITY_SUBMODULE="wifi"
inherit trinity-meta

DESCRIPTION="Trinity wifi (wireless network) gui"
KEYWORDS="amd64 x86"
IUSE="arts"

DEPEND="
	net-wireless/wireless-tools
	arts? ( trinity-base/arts )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/kwifimanager-fix-3.5.13.1.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
