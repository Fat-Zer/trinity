# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS=""
IUSE="cups"

DEPEND="cups? ( net-print/cups )"
RDEPEND="${DEPEND}
	app-text/enscript
	app-text/psutils"
