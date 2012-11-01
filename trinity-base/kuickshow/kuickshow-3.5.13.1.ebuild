# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="A fast and versatile image viewer for Trinity"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/libXext
	media-libs/imlib"
RDEPEND="${DEPEND}"
