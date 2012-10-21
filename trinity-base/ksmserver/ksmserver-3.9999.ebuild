# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The reliable Trinity session manager that talks the standard X11R6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/dbus-tqt"
#    sys-apps/hal"
RDEPEND="${RDEPEND}"
