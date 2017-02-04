# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity eject frontend"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="trinity-base/kdialog:${SLOT}"
RDEPEND="${DEPEND}
	virtual/eject"
