# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity remote desktop connection (RDP and VNC) client"
KEYWORDS=
IUSE="rdesktop slp"

DEPEND="
	dev-libs/openssl
	slp? ( net-libs/openslp )
	x11-libs/libXext"
RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with slp SLP)
	)

	trinity-meta_src_configure
}
