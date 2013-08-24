# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="Trinity PIM identities library"
KEYWORDS=""
IUSE+=""

COMMON_DEPEND=">=trinity-base/certmanager-${PV}:${SLOT}
	>=trinity-base/libtdepim-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}"
DEPEND+=" $COMMON_DEPEND"
RDEPEND+=" $COMMON_DEPEND"
