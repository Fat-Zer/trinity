# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity splashscreen framework (of Trinity itself, not of individual apps)"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

DEPEND="x11-libs/libXcursor
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="$DEPEND"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xinerama XINERAMA)
	)

	trinity-meta_src_configure
}
