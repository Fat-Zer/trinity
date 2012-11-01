# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity GUI for passwd"
KEYWORDS=""
IUSE=""

DEPEND=">=trinity-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
