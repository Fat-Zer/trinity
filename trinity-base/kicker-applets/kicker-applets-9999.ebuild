# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta

DESCRIPTION="kicker applets"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-base/kicker-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

# no xmms support
