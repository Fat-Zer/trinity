# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="kdepim"

inherit trinity-meta

DESCRIPTION="Trinity PIM identities library"
KEYWORDS="~amd64 ~x86"
IUSE+=""

COMMON_DEPEND=">=trinity-base/certmanager-${PV}:${SLOT}
	>=trinity-base/libkdepim-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}"
DEPEND+=" $COMMON_DEPEND"
RDEPEND+=" $COMMON_DEPEND"

TSM_EXTRACT_ALSO="libkdepim/ libemailfunctions/ libkmime/"
