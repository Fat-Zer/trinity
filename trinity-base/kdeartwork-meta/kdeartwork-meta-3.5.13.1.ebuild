# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

inherit trinity-functions

set-trinityver

DESCRIPTION="kdeartwork meta package - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_LIVEVER"
IUSE=""

RDEPEND="
	>=trinity-base/kdeartwork-emoticons-${PV}:${SLOT}
	>=trinity-base/kdeartwork-icon-themes-${PV}:${SLOT}
	>=trinity-base/kdeartwork-icewm-themes-${PV}:${SLOT}
	>=trinity-base/kdeartwork-kscreensaver-${PV}:${SLOT}
	>=trinity-base/kdeartwork-kwin-styles-${PV}:${SLOT}
	>=trinity-base/kdeartwork-kworldclock-${PV}:${SLOT}
	>=trinity-base/kdeartwork-sounds-${PV}:${SLOT}
	>=trinity-base/kdeartwork-styles-${PV}:${SLOT}
	>=trinity-base/kdeartwork-wallpapers-${PV}:${SLOT}"
