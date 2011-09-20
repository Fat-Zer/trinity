# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="kicker applet for KDE and X clipboard management"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libXfixes"
RDEPEND="${RDEPEND}"

src_configure() {
# FIXME: check if it's neccecery
	mycmakeargs=(
		-DWITH_XFIXES=ON
	)

	trinity-meta_src_configure
}
