# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"

inherit trinity-functions

set-trinityver

DESCRIPTION="kdetoys metapackage - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_VER"
IUSE=""
KEYWORDS=

RDEPEND="
	>=trinity-base/amor-${PV}:${SLOT}
	>=trinity-base/eyesapplet-${PV}:${SLOT}
	>=trinity-base/fifteenapplet-${PV}:${SLOT}
	>=trinity-base/tdetoys-doc-${PV}:${SLOT}
	>=trinity-base/kmoon-${PV}:${SLOT}
	>=trinity-base/kodo-${PV}:${SLOT}
	>=trinity-base/kteatime-${PV}:${SLOT}
	>=trinity-base/ktux-${PV}:${SLOT}
	>=trinity-base/kweather-${PV}:${SLOT}
	>=trinity-base/kworldclock-${PV}:${SLOT}"
