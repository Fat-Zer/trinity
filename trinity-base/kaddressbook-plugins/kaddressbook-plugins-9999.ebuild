# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta

DESCRIPTION="Plugins for Trinity Addressbook"
KEYWORDS=""
IUSE+=""
DEPEND=">=trinity-base/kaddressbook-${PV}:${SLOT}"

RDEPEND="${DEPEND}"
