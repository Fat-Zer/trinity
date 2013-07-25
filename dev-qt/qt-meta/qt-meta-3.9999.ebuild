# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3

DESCRIPTION="This is a meta package for a Qt3 toolkit it is needed to keep dependencies clean"
HOMEPAGE="http://qt.nokia.com/ http://www.trinitydesktop.org/"

LICENSE="|| ( QPL-1.0 GPL-2 GPL-3 )"
SLOT="3"
KEYWORDS=
IUSE="cups debug doc examples firebird ipv6 mysql nas nis opengl postgres sqlite xinerama"

DEPEND="
	=dev-qt/qt-${PV}:${SLOT}[cups=,debug=,doc=,examples=,firebird=,ipv6=,mysql=]
	=dev-qt/qt-${PV}:${SLOT}[nas=,nis=,opengl=,postgres=,sqlite=,xinerama=]"
RDEPEND="${DEPEND}"

pkg_postinst() {
	echo
	einfo "Please note that this meta package is only provided for capability."
	einfo "No packages should depend directly on this meta package, but on the"
	einfo "dev-qt/qt:${SLOT} package."
	echo
}
