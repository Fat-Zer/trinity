# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity DVI viewer"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/freetype:2
	>=trinity-base/kviewshell-${PV}:${SLOT}"
RDEPEND="$DEPEND"

TSM_EXTRACT_ALSO="kviewshell"
