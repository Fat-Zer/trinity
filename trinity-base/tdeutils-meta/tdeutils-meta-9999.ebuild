# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"

inherit trinity-functions

set-trinityver

DESCRIPTION="tdeutils metapackage - merge this to pull in all tdeutils-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_VER"
IUSE=""
KEYWORDS=""

RDEPEND="
	>=trinity-base/ark-${PV}:${SLOT}
	>=trinity-base/tdeutils-doc-${PV}:${SLOT}
	>=trinity-base/kcalc-${PV}:${SLOT}
	>=trinity-base/kcharselect-${PV}:${SLOT}
	>=trinity-base/tdelirc-${PV}:${SLOT}
	>=trinity-base/kdf-${PV}:${SLOT}
	>=trinity-base/kedit-${PV}:${SLOT}
	>=trinity-base/kfloppy-${PV}:${SLOT}
	>=trinity-base/kgpg-${PV}:${SLOT}
	>=trinity-base/khexedit-${PV}:${SLOT}
	>=trinity-base/kjots-${PV}:${SLOT}
	>=trinity-base/klaptopdaemon-${PV}:${SLOT}
	>=trinity-base/kmilo-${PV}:${SLOT}
	>=trinity-base/kregexpeditor-${PV}:${SLOT}
	>=trinity-base/ksim-${PV}:${SLOT}
	>=trinity-base/ktimer-${PV}:${SLOT}
	>=trinity-base/tdewallet-${PV}:${SLOT}
	>=trinity-base/superkaramba-${PV}:${SLOT}"
