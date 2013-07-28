# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"
TRINITY_LANGS="ar bg ca da de el en_GB es et fi fr gl he hu it ja ka ko pa pt ru sr sr@Latn sv tr zh_CN zh_TW"
TRINITY_DOC_LANGS="da es et it pt ru sv"

inherit trinity-base

DESCRIPTION="A user friendly IRC Client for Trinity"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"

need-trinity 14.0.0

SLOT="${TRINITY_VER}"
IUSE="xscreensaver"

DEPEND="xscreensaver? ( x11-libs/libXScrnSaver )"
RDEPEND="$DEPEND"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xscreensaver XSCREENSAVER)
	)

	trinity-base_src_configure
}
