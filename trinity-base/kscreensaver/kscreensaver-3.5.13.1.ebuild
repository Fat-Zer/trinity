# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity screensaver framework"
KEYWORDS="x86 amd64"
IUSE="opengl +krootbacking"
# CHECKME: if this use needed
DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )
	krootbacking? ( >=trinity-base/krootbacking-${PV}:${TRINITY_VER} )"
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
