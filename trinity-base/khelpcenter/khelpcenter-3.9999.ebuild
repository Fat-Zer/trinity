# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
KMMODULE="khelpcenter doc"
EAPI="3"
inherit trinity-meta

DESCRIPTION="The KDE help center."
KEYWORDS=""

RDEPEND="
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=www-misc/htdig-3.2.0_beta6-r1"
IUSE=""
