# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="An advanced download manager for Trinity"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/libXext"
RDEPEND="${DEPEND}"
