# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
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

TSM_EXTRACT_ALSO="libtdepim/ libemailfunctions/ libkmime/"
