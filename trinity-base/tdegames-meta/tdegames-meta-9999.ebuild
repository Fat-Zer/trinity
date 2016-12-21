# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"

inherit trinity-functions

set-trinityver

DESCRIPTION="kdegraphics metapackage - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="${TRINITY_VER}"
IUSE=""
KEYWORDS=

RDEPEND="
	>=trinity-apps/atlantik-${PV}:${SLOT}
	>=trinity-base/tdegames-doc-${PV}:${SLOT}
	>=trinity-apps/kasteroids-${PV}:${SLOT}
	>=trinity-apps/katomic-${PV}:${SLOT}
	>=trinity-apps/kbackgammon-${PV}:${SLOT}
	>=trinity-apps/kbattleship-${PV}:${SLOT}
	>=trinity-apps/kblackbox-${PV}:${SLOT}
	>=trinity-apps/kbounce-${PV}:${SLOT}
	>=trinity-apps/kenolaba-${PV}:${SLOT}
	>=trinity-apps/kfouleggs-${PV}:${SLOT}
	>=trinity-apps/kgoldrunner-${PV}:${SLOT}
	>=trinity-apps/kjumpingcube-${PV}:${SLOT}
	>=trinity-apps/klickety-${PV}:${SLOT}
	>=trinity-apps/klines-${PV}:${SLOT}
	>=trinity-apps/kmahjongg-${PV}:${SLOT}
	>=trinity-apps/kmines-${PV}:${SLOT}
	>=trinity-apps/knetwalk-${PV}:${SLOT}
	>=trinity-apps/kolf-${PV}:${SLOT}
	>=trinity-apps/konquest-${PV}:${SLOT}
	>=trinity-apps/kpat-${PV}:${SLOT}
	>=trinity-apps/kpoker-${PV}:${SLOT}
	>=trinity-apps/kreversi-${PV}:${SLOT}
	>=trinity-apps/ksame-${PV}:${SLOT}
	>=trinity-apps/kshisen-${PV}:${SLOT}
	>=trinity-apps/ksirtet-${PV}:${SLOT}
	>=trinity-apps/ksmiletris-${PV}:${SLOT}
	>=trinity-apps/ksnake-${PV}:${SLOT}
	>=trinity-apps/ksokoban-${PV}:${SLOT}
	>=trinity-apps/kspaceduel-${PV}:${SLOT}
	>=trinity-apps/ktron-${PV}:${SLOT}
	>=trinity-apps/ktuberling-${PV}:${SLOT}
	>=trinity-base/libtdegames-${PV}:${SLOT}
	>=trinity-apps/lskat-${PV}:${SLOT}
	>=trinity-apps/twin4-${PV}:${SLOT}"
