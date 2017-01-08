# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="A Trinity Viewer for PostScript (.ps, .eps) and PDF (.pdf) files"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/libXft"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/tdegraphics-fix-${PN}-parallel-compilation.patch" )
