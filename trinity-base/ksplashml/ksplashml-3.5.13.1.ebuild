# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity splashscreen framework (the splashscreen of Trinity itself, not of individual apps)"
KEYWORDS="x86 amd64"
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
