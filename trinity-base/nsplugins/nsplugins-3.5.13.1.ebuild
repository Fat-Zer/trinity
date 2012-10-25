# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="x86 amd64"
IUSE=""

# CHECKME: dependencies
DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"
RDEPEND="${DEPEND}"
