# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS=""
IUSE="java"
# FIXME: support branding USE flag
DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	java? ( >=virtual/jre-1.4 )"
