# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE screensaver framework"
KEYWORDS=""
IUSE="opengl"
# CHECKME: if this use needed
DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"
