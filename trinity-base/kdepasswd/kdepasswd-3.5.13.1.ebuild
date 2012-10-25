# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity GUI for passwd"
KEYWORDS="x86 amd64"
IUSE=""

# CHECKME: if this is neccecery
DEPEND="trinity-base/libkonq:${SLOT}"
RDEPEND="${DEPEND}"
