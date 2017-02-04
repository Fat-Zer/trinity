# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity: Web browser, file manager, ..."
KEYWORDS=
IUSE="java"
# FIXME: support branding USE flag

DEPEND="
	>=trinity-base/libkonq-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	>=trinity-base/kcontrol-${PV}:${SLOT}
	>=trinity-base/tdebase-tdeioslaves-${PV}:${SLOT}
	>=trinity-base/kfind-${PV}:${SLOT}
	java? ( >=virtual/jre-1.4 )"

TSM_EXTRACT_ALSO="kdesktop"
