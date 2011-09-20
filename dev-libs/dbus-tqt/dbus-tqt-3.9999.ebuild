# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="dependencies/${PN}"
inherit trinity-base

DESCRIPTION="D-BUS TQt bindings"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="x11-libs/qt-meta:3"

S=${WORKDIR}/dbus-tqt

src_configure() {
	mycmakeargs=(
	)

	cmake-utils_src_configure
}
