# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS=""
IUSE=""

# CHECKME: if this is neccecery
DEPEND="kde-base/libkonq:${SLOT}"
RDEPEND="${DEPEND}"
