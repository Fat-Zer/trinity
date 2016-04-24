# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdepim"

inherit trinity-meta

DESCRIPTION="Trinity news feed aggregator."
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=trinity-base/ktnef-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}
	>=trinity-base/libkdepim-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libkdepim/"
