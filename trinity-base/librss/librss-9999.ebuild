# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity rss library"
KEYWORDS=""
IUSE=""

PATCHES=( "${FILESDIR}/tdenetwork-fix-export-librss.patch" )
