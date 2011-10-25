# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit trinity-functions

set-kdever

DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_LIVEVER"
IUSE=""

RDEPEND="
>=kde-base/kdeartwork-emoticons-${PV}:${SLOT}
>=kde-base/kdeartwork-iconthemes-${PV}:${SLOT}
>=kde-base/kdeartwork-icewm-themes-${PV}:${SLOT}
>=kde-base/kdeartwork-kscreensaver-${PV}:${SLOT}
>=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}
>=kde-base/kdeartwork-kworldclock-${PV}:${SLOT}
>=kde-base/kdeartwork-sounds-${PV}:${SLOT}
>=kde-base/kdeartwork-styles-${PV}:${SLOT}
>=kde-base/kdeartwork-wallpapers-${PV}:${SLOT}"
