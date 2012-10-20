# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE eject frontend"
KEYWORDS=""
IUSE=""

DEPEND="kde-base/kdialog:${SLOT}"
RDEPEND="${RDEPEND}
	virtual/eject"
