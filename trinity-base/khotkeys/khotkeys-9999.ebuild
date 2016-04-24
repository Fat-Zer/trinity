# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="4"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

need-arts optional

DESCRIPTION="Trinity hotkey daemon"
KEYWORDS=""

DEPEND+=" x11-libs/libXtst"
RDEPEND+=" x11-libs/libXtst"

src_configure() {
	mycmakeargs=(
		-D_WITH_XTEST=ON
	)

	trinity-meta_src_configure
}
