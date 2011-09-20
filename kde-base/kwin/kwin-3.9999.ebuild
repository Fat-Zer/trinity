# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
KMMODULE="kwin xrender xfiles xext"
EAPI="3"
inherit trinity-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS=""
IUSE="xcomposite"

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
	# 					 x11-libs/libXdamage )"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
	)

	trinity-meta_src_configure
}
