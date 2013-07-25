# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="Kooka is a Trinity application which provides access to scanner hardware"
KEYWORDS=""
IUSE=""

DEPEND="
	>=trinity-base/libkscan-${PV}:${SLOT}
	media-libs/tiff"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libkscan"
