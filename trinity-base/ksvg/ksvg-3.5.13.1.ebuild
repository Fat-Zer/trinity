# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=media-libs/freetype-2.2
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms:0
	dev-libs/fribidi"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-bug1311.patch"
