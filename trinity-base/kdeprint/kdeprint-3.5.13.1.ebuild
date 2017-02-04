# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity printer queue/device manager"
KEYWORDS="x86 amd64"
IUSE="cups"

DEPEND="cups? ( net-print/cups )"
RDEPEND="${DEPEND}
	app-text/enscript
	app-text/psutils"
