# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="Kooka is a Trinity application which provides access to scanner hardware"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	>=trinity-base/libkscan-${PV}:${SLOT}
	media-libs/tiff"
RDEPEND="${DEPEND}"
