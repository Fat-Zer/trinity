# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="dependencies/${PN}"

inherit cmake-utils trinity-base # subversion

DESCRIPTION="Interface and abstraction library for Qt and Trinity"
HOMEPAGE="http://trinitydesktop.org/"
# SRC_URI="http://www.thel.ro/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="+qt3 -qt4"
SLOT="0"

RDEPEND="qt3? ( x11-libs/qt-meta:3 )
	qt4? ( x11-libs/qt-meta:4 )"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_configure() {
	mycmakeargs=(
	    $(cmake-utils_use qt3 USE_QT3)
	    $(cmake-utils_use qt4 USE_QT4)
	 )

	 cmake-utils_src_configure
}
