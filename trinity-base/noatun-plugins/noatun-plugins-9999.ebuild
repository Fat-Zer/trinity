# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta db-use

DESCRIPTION="Various plugins for Noatun."
KEYWORDS=""
IUSE="arts sdl berkdb"

COMMON_DEPEND="
	>=trinity-base/noatun-${PV}:${SLOT}
	arts? ( >=trinity-base/arts-${PV}:${SLOT} )
	berkdb? ( =sys-libs/db-4*:= )
"
DEPEND="${COMMON_DEPEND}
	sdl? ( >=media-libs/libsdl-1.2 )
"

RDEPEND="${COMMON_DEPEND}
	sdl? ( >=media-libs/libsdl-1.2[X] )
"

src_compile() {
	mycmakeargs=(
		"-DWITH_ARTS=$(usex arts)"
		"-DWITH_SDL=$(usex sdl)"
	)

	if use berkdb; then
		mycmakeargs=( "${mycmakeargs[@]}"
			"-DWITH_BERKELEY_DB=ON"
			"-DBERKELEY_DB_LIBS=$(db_libname)"
			"-DBERKELEY_DB_INCLUDE_DIRS==${ROOT}$(db_includedir)"
		)
	else
		mycmakeargs=( "${mycmakeargs[@]}"
			"-DWITH_BERKELEY_DB=OFF"
		)
	fi

	trinity-meta_src_configure
}
