# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS=""
IUSE=""

# CHECKME: dependencies
DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"
RDEPEND="${RDEPEND}"
