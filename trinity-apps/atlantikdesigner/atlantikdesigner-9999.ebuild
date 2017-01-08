# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta

DESCRIPTION="Atlantik gameboard designer"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-apps/atlantik-${PV}:${SLOT}"
