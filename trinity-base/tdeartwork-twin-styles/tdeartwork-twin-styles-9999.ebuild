# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="4"
TRINITY_MODULE_NAME="tdeartwork"

inherit trinity-meta
DESCRIPTION="Window styles for Trinity"
KEYWORDS=
IUSE=""

DEPEND=">=trinity-base/twin-${PV}:${SLOT}"
RDEPEND="$DEPEND"
