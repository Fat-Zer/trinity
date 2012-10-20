# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="X terminal for use with KDE."
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst"

RDEPEND="${DEPEND}
	x11-apps/bdftopcf"

# For kcm_konsole module
RDEPEND="${RDEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}"
#FIXME: check if it is neccecery
