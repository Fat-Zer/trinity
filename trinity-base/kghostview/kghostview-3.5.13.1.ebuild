# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="A Trinity Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="x11-libs/libXft"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/tdegraphics-fix-${PN}-parallel-compilation.patch" )
