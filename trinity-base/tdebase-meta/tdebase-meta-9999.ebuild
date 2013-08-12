# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"

inherit trinity-functions

set-trinityver

DESCRIPTION="tdebase metapackage - merge this to pull in all tdebase-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_VER"
KEYWORDS=
IUSE=""

RDEPEND=">=trinity-base/tdeinit-${PV}:${SLOT}
	>=trinity-base/drkonqi-${PV}:${SLOT}
	>=trinity-base/kappfinder-${PV}:${SLOT}
	>=trinity-base/kate-${PV}:${SLOT}
	>=trinity-base/kcheckpass-${PV}:${SLOT}
	>=trinity-base/kcminit-${PV}:${SLOT}
	>=trinity-base/kcontrol-${PV}:${SLOT}
	>=trinity-base/kdcop-${PV}:${SLOT}
	>=trinity-base/kdebugdialog-${PV}:${SLOT}
	>=trinity-base/tdepasswd-${PV}:${SLOT}
	>=trinity-base/tdeprint-${PV}:${SLOT}
	>=trinity-base/kdesktop-${PV}:${SLOT}
	>=trinity-base/tdesu-${PV}:${SLOT}
	>=trinity-base/kdialog-${PV}:${SLOT}
	>=trinity-base/tdm-${PV}:${SLOT}
	>=trinity-base/kfind-${PV}:${SLOT}
	>=trinity-base/khelpcenter-${PV}:${SLOT}
	>=trinity-base/khotkeys-${PV}:${SLOT}
	>=trinity-base/kicker-${PV}:${SLOT}
	>=trinity-base/tdebase-tdeioslaves-${PV}:${SLOT}
	>=trinity-base/klipper-${PV}:${SLOT}
	>=trinity-base/kmenuedit-${PV}:${SLOT}
	>=trinity-base/konqueror-${PV}:${SLOT}
	>=trinity-base/konsole-${PV}:${SLOT}
	>=trinity-base/kpager-${PV}:${SLOT}
	>=trinity-base/kpersonalizer-${PV}:${SLOT}
	>=trinity-base/kreadconfig-${PV}:${SLOT}
	>=trinity-base/tdescreensaver-${PV}:${SLOT}
	>=trinity-base/ksmserver-${PV}:${SLOT}
	>=trinity-base/ksplashml-${PV}:${SLOT}
	>=trinity-base/kstart-${PV}:${SLOT}
	>=trinity-base/ksysguard-${PV}:${SLOT}
	>=trinity-base/ksystraycmd-${PV}:${SLOT}
	>=trinity-base/ktip-${PV}:${SLOT}
	>=trinity-base/twin-${PV}:${SLOT}
	>=trinity-base/kxkb-${PV}:${SLOT}
	>=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/nsplugins-${PV}:${SLOT}
	>=trinity-base/knetattach-${PV}:${SLOT}
	>=trinity-base/tdebase-data-${PV}:${SLOT}
	>=trinity-base/krootbacking-${PV}:${SLOT}
	>=trinity-base/tqt3integration-${PV}:${SLOT}"
