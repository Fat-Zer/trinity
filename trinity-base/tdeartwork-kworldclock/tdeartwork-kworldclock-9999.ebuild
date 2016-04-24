# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="4"
TRINITY_MODULE_NAME="tdeartwork"

inherit trinity-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS=
IUSE=""

RDEPEND="$DEPEND
	>=trinity-base/kworldclock-${PV}:${SLOT}"
