# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity RSS server and client for DCOP"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=trinity-base/librss-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="librss/"
