# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_TYPE="applications"
TRINITY_MODULE_VER="3.5.13.1"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"
TRINITY_LANGS="ar bg ca da de el en_GB es et fi fr gl he hu it ja ka ko pa pt ru sr sr@Latn sv tr zh_CN zh_TW"
TRINITY_DOC_LANGS="da es et it pt ru sv"

inherit trinity-base

DESCRIPTION="A user friendly IRC Client for Trinity"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"

need-trinity 3.5.13

SLOT="${TRINITY_VER}"
IUSE="xscreensaver"

DEPEND="xscreensaver? ( x11-libs/libXScrnSaver )"
RDEPEND="$DEPEND"

PATCHES=( "${FILESDIR}/${PN}-${TRINITY_MODULE_VER}-initial-cmake.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-base_src_configure
}
