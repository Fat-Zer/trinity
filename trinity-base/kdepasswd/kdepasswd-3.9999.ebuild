# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity GUI for passwd"
KEYWORDS=""
IUSE=""

# CHECKME: if this is neccecery
DEPEND="trinity-base/libkonq:${SLOT}"
RDEPEND="${DEPEND}"
