# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="A Trinity Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS=
IUSE=""

DEPEND="x11-libs/libXft"
RDEPEND="${DEPEND}"
