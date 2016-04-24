# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity remote desktop connection (RDP and VNC) client"
KEYWORDS="amd64 x86"
IUSE="rdesktop slp"

DEPEND="
	dev-libs/openssl
	slp? ( net-libs/openslp )
	x11-libs/libXext"
RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )"

PATCHES=( "${FILESDIR}/krdc-3.5.13.1-702c180-added-openslp-support-to-cmake.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with slp SLP)
	)

	trinity-meta_src_configure
}
