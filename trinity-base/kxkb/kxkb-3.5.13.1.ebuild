# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="KControl module for the X11 keyboard extension to configure and switch between keyboard mappings."
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/libXtst"
RDEPEND="${DEPEND}
	x11-misc/xkeyboard-config
	x11-apps/setxkbmap"

src_configure() {
	mycmakeargs=(
		-DWITH_XTEST=ON
	)

	trinity-meta_src_configure
}
