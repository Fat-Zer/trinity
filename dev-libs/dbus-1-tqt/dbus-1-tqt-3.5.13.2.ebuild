# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="dbus-1-tqt"

inherit trinity-base

DESCRIPTION="D-BUS TQt bindings"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-qt/qt-3.3.8d:3
	sys-apps/dbus
	dev-qt/tqtinterface"
RDEPEND="$DEPEND"

src_configure() {
	cmake-utils_src_configure
}
