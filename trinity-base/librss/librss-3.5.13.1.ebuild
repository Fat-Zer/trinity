# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity rss library"
KEYWORDS="amd64 x86"
IUSE=""

PATCHES=( "${FILESDIR}/tdenetwork-fix-export-librss.patch" )
