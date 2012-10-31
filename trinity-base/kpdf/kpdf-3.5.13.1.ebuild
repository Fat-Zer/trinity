# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="kpdf, a Trinity pdf viewer based on xpdf"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="media-libs/freetype:2"
RDEPEND="$DEPEND"
