# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"

inherit trinity-functions

set-trinityver

DESCRIPTION="tdeaddons metapackage - merge this to pull in all tdeaddons-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="${TRINITY_VER}"
IUSE=""
KEYWORDS=

RDEPEND="
	>=trinity-apps/atlantikdesigner-${PV}:${SLOT}
	>=trinity-base/tdeaddons-doc-${PV}:${SLOT}
	>=trinity-base/kaddressbook-plugins-${PV}:${SLOT}
	>=trinity-base/kate-plugins-${PV}:${SLOT}
	>=trinity-base/kicker-applets-${PV}:${SLOT}
	>=trinity-base/knewsticker-scripts-${PV}:${SLOT}
	>=trinity-base/konq-plugins-${PV}:${SLOT}
	>=trinity-base/ksig-${PV}:${SLOT}
	>=trinity-base/renamedlg-plugins-${PV}:${SLOT}
	>=trinity-base/tdeaddons-tdefile-plugins-${PV}:${SLOT}
"
# trinity-base/noatun-plugins masked due to missing dependency: noatun
