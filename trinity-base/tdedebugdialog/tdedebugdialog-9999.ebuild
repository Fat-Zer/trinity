# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="A Trinity dialog box for setting preferences for debug output."
KEYWORDS=
IUSE=""
RDEPEND+=" !trinity-base/kdebugdialog:${SLOT}"
