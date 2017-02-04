# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity Screenshot Utility"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/libXext"
RDEPEND="$DEPEND"
