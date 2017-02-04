# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS=
IUSE=""

# CHECKME: dependencies
DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"
RDEPEND="${DEPEND}"
