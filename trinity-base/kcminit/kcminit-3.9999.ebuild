# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst"
DEPEND="${RDEPEND}"
