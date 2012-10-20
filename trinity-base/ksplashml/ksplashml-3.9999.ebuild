# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS=""
IUSE="xinerama"

DEPEND="x11-libs/libXcursor
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="x11-libs/libXcursor
	xinerama? ( x11-libs/libXinerama )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xinerama XINERAMA)
	)

	trinity-meta_src_configure
}
