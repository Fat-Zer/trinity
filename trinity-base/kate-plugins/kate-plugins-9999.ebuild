# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"
TSM_EXTRACT="kate"

inherit trinity-meta

DESCRIPTION="kate plugins and docs"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-base/kate-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
