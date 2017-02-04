# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity scanner library"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-gfx/sane-backends"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/tdegraphics-${PN}-fix-name.patch" )
