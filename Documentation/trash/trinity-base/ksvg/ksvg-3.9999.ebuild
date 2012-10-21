# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdegraphics"
EAPI="4"
inherit trinity-meta

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS=""
IUSE=""

DEPEND="
	>=media-libs/freetype-2.3
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
RDEPEND="$DEPEND"
