# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdenetwork"
TRINITY_SUBMODULE="wifi"
inherit trinity-meta

DESCRIPTION="Trinity wifi (wireless network) gui"
KEYWORDS=
IUSE="arts"

DEPEND="
	net-wireless/wireless-tools
	arts? ( trinity-base/arts )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with arts ARTS)
	)

	trinity-meta_src_configure
}
