# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="Trinity PIM exchange library"
KEYWORDS=""
IUSE+=""
COMMON_DEPEND=">=trinity-base/libkcal-${PV}:${SLOT}
	>=trinity-base/ktnef-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}"

DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"
