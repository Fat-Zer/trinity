# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="Trinity Notes application"
KEYWORDS=""
IUSE+=""

COMMON_DEPEND=">=trinity-base/libkcal-${PV}:${SLOT}
	>=trinity-base/libtdepim-${PV}:${SLOT}"
DEPEND+=" $COMMON_DEPEND"
RDEPEND+=" $COMMON_DEPEND"

TSM_EXTRACT_ALSO="libtdepim/"
