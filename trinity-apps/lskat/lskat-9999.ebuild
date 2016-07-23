# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegames"

inherit trinity-meta

DESCRIPTION="Trinity card game"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-base/libtdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
