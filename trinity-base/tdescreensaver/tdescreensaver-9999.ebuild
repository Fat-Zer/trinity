# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity screensaver framework"
KEYWORDS=
IUSE="opengl +krootbacking"
# CHECKME: if this use needed
DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )
	krootbacking? ( trinity-base/krootbacking )"
RDEPEND="${DEPEND}"

src_configure () {
	if use opengl; then
		ewarn "OpenGL is not supported by trinity build system yet."
		ewarn "This use flag is here just for future/past capability"
	fi

	mycmakeargs=(
		$(cmake-utils_use_with opengl OPENGL )
	)

	trinity-meta_src_configure
}
