# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdeartwork"
EAPI="4"
inherit trinity-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=">=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}"

pkg_postinst() {
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
