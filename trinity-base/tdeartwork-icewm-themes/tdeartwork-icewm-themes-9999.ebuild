# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="4"
TRINITY_MODULE_NAME="tdeartwork"

inherit trinity-meta

DESCRIPTION="Themes for IceWM from the Trinityartwork package."
KEYWORDS=
IUSE=""

RDEPEND="$DEPEND
	>=trinity-base/tdeartwork-twin-styles-${PV}:${SLOT}"

pkg_postinst() {
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
