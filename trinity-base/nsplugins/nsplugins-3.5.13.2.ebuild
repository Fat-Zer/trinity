# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~amd64 ~x86"
IUSE=""

# CHECKME: dependencies
DEPEND="x11-libs/libXt
	=dev-libs/glib-2*"
RDEPEND="${DEPEND}"
