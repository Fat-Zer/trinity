# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="kicker plugin: rss news ticker"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=trinity-base/librss-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/knewsticker-a2b3834-fix-various-cmake-build-issues.patch" )
TSM_EXTRACT_ALSO="librss/"
