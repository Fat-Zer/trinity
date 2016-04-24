# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity DVI viewer"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="media-libs/freetype:2
	>=trinity-base/kviewshell-${PV}:${SLOT}"
RDEPEND="$DEPEND"

TSM_EXTRACT_ALSO="kviewshell"
