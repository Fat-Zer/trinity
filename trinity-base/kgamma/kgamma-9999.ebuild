# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity screen gamma values kcontrol module"
KEYWORDS=
IUSE=""

DEPEND=">=trinity-base/kcontrol-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
