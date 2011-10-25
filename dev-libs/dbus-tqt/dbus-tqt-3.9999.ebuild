# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
KMNAME="dependencies/dbus-tqt"
EAPI="2"

inherit trinity-base

DESCRIPTION="D-BUS TQt bindings"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="x11-libs/qt-meta:3
	kde-base/tqtinterface"
RDEPEND="$DEPEND"

S=${WORKDIR}/dbus-tqt

src_configure() {
	mycmakeargs=(	)

	cmake-utils_src_configure
}
