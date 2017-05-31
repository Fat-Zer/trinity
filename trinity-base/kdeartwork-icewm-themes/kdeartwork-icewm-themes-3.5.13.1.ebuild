# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdeartwork"

inherit trinity-meta

DESCRIPTION="Themes for IceWM from the Trinityartwork package."
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="$DEPEND
	>=trinity-base/kdeartwork-kwin-styles-${PV}:${SLOT}"

pkg_postinst() {
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
