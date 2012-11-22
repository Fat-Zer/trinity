# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"

inherit trinity-functions

set-trinityver

DESCRIPTION="tdenetwork metapackage - merge this to pull in all tdenetwork-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="$TRINITY_LIVEVER"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=trinity-base/dcoprss-${PV}:${SLOT}
	>=trinity-base/kdict-${PV}:${SLOT}
	>=trinity-base/kdnssd-${PV}:${SLOT}
	>=trinity-base/kget-${PV}:${SLOT}
	>=trinity-base/knewsticker-${PV}:${SLOT}
	>=trinity-base/kopete-${PV}:${SLOT}
	>=trinity-base/kpf-${PV}:${SLOT}
	>=trinity-base/kppp-${PV}:${SLOT}
	>=trinity-base/krdc-${PV}:${SLOT}
	>=trinity-base/krfb-${PV}:${SLOT}
	>=trinity-base/ksirc-${PV}:${SLOT}
	>=trinity-base/ktalkd-${PV}:${SLOT}
	>=trinity-base/kwifimanager-${PV}:${SLOT}
	>=trinity-base/librss-${PV}:${SLOT}
	>=trinity-base/lisa-${PV}:${SLOT}
	>=trinity-base/tdenetwork-doc-${PV}:${SLOT}
	>=trinity-base/tdenetwork-filesharing-${PV}:${SLOT}
	>=trinity-base/tdenetwork-kfile-plugins-${PV}:${SLOT}"
