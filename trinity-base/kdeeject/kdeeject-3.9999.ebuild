# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity eject frontend"
KEYWORDS=""
IUSE=""

DEPEND="trinity-base/kdialog:${SLOT}"
RDEPEND="${RDEPEND}
	virtual/eject"
