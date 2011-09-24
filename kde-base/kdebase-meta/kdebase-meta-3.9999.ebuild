# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit trinity-functions

set-kdever

DESCRIPTION="kdebase - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_LIVEVER"
KEYWORDS=""
IUSE=""

RDEPEND=">=kde-base/kdebase-startkde-${PV}:${SLOT}
>=kde-base/drkonqi-${PV}:${SLOT}
>=kde-base/kappfinder-${PV}:${SLOT}
>=kde-base/kate-${PV}:${SLOT}
>=kde-base/kcheckpass-${PV}:${SLOT}
>=kde-base/kcminit-${PV}:${SLOT}
>=kde-base/kcontrol-${PV}:${SLOT}
>=kde-base/kdcop-${PV}:${SLOT}
>=kde-base/kdebugdialog-${PV}:${SLOT}
>=kde-base/kdepasswd-${PV}:${SLOT}
>=kde-base/kdeprint-${PV}:${SLOT}
>=kde-base/kdesktop-${PV}:${SLOT}
>=kde-base/kdesu-${PV}:${SLOT}
>=kde-base/kdialog-${PV}:${SLOT}
>=kde-base/kdm-${PV}:${SLOT}
>=kde-base/kfind-${PV}:${SLOT}
>=kde-base/khelpcenter-${PV}:${SLOT}
>=kde-base/khotkeys-${PV}:${SLOT}
>=kde-base/kicker-${PV}:${SLOT}
>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
>=kde-base/klipper-${PV}:${SLOT}
>=kde-base/kmenuedit-${PV}:${SLOT}
>=kde-base/konqueror-${PV}:${SLOT}
>=kde-base/konsole-${PV}:${SLOT}
>=kde-base/kpager-${PV}:${SLOT}
>=kde-base/kpersonalizer-${PV}:${SLOT}
>=kde-base/kreadconfig-${PV}:${SLOT}
>=kde-base/kscreensaver-${PV}:${SLOT}
>=kde-base/ksmserver-${PV}:${SLOT}
>=kde-base/ksplashml-${PV}:${SLOT}
>=kde-base/kstart-${PV}:${SLOT}
>=kde-base/ksysguard-${PV}:${SLOT}
>=kde-base/ksystraycmd-${PV}:${SLOT}
>=kde-base/ktip-${PV}:${SLOT}
>=kde-base/kwin-${PV}:${SLOT}
>=kde-base/kxkb-${PV}:${SLOT}
>=kde-base/libkonq-${PV}:${SLOT}
>=kde-base/nsplugins-${PV}:${SLOT}
>=kde-base/knetattach-${PV}:${SLOT}
>=kde-base/kdebase-data-${PV}:${SLOT}
>=kde-base/krootbacking-${PV}:${SLOT}
>=kde-base/tsak-${PV}:${SLOT}"
