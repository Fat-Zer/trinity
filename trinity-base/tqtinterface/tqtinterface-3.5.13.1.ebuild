# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="${PN}"

inherit trinity-base

DESCRIPTION="Interface and abstraction library for Qt and Trinity"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE="+qt3 -qt4"
SLOT="0"

DEPEND="qt3? ( >=x11-libs/qt-3.3.8d:3 )
	qt4? ( x11-libs/qt-meta:4 )"

RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
	    $(cmake-utils_use qt3 USE_QT3)
	    $(cmake-utils_use qt4 USE_QT4)
	 )

	 cmake-utils_src_configure
}
