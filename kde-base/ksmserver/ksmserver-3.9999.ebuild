# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="The reliable KDE session manager that talks the standard X11R6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/dbus-tqt"
#    sys-apps/hal"
RDEPEND="${RDEPEND}"
