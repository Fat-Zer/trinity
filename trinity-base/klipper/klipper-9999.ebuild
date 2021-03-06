# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="kicker applet for Trinity and X clipboard management"
KEYWORDS=
IUSE=""

DEPEND="x11-libs/libXfixes"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_XFIXES=ON
	)

	trinity-meta_src_configure
}
