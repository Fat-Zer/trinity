# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="tdegraphics"
TRINITY_SUBMODULE="kfax kfaxview"

inherit trinity-meta

DESCRIPTION="Trinity G3/G4 fax viewer"
KEYWORDS=
IUSE=""

DEPEND=">=trinity-base/kviewshell-${PV}:${SLOT}"
RDEPEND="$DEPEND"

TSM_EXTRACT_ALSO="kviewshell"
