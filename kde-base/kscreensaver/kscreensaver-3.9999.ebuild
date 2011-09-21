# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE screensaver framework"
KEYWORDS=""
IUSE="opengl +rootbacking"
# CHECKME: if this use needed
DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )
	rootbacking? ( kde-base/krootbacking )"
RDEPEND="${DEPEND}"

src_install () {
	if use opengl; then
		ewarn "OpenGL is not supported by trinity build system yet."
		ewarn "This use flag is here just for future/past capability"
	fi

	mycmakeargs=(
		$(cmake-utils_use_with opengl OPENGL )
	)

	trinity-meta_src_configure
}
