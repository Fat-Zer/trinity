# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity: A dialer and front-end to pppd."
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-dialup/ppp"

PATCHES=(
	"${FILESDIR}/kppp-v3.5.13.1-a2b3834-fix-various-cmake-build-issues.patch" )
