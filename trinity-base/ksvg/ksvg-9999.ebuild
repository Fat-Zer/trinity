# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS=
IUSE=""

DEPEND=">=media-libs/freetype-2.2
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms:0
	dev-libs/fribidi"
RDEPEND="${DEPEND}"
