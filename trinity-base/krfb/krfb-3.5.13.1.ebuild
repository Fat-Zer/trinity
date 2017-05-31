# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="VNC-compatible server to share Trinity desktops"
KEYWORDS="amd64 x86"
IUSE="slp"

DEPEND="
	dev-libs/openssl:=
	slp? ( net-libs/openslp )
	x11-libs/libXext"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/krfb-3.5.13.1-702c180-added-openslp-support-to-cmake.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with slp SLP)
	)

	trinity-meta_src_configure
}
