# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="KDE login manager, similar to xdm and gdm"
KEYWORDS=""
IUSE="+shadow pam xdmcp"

DEPEND="pam? ( kde-base/kdebase-pam )
	xdmcp? ( x11-libs/libXdmcp )
	sys-apps/dbus
	x11-libs/libXau
	x11-libs/libXtst
	>=kde-base/kcontrol-${PV}:${SLOT}"
	# Requires the desktop background settings and kdm kcontrol modules
RDEPEND="${DEPEND}
	>=kde-base/kdepasswd-${PV}:${SLOT}
	x11-apps/xinit
	x11-apps/xmessage"
# PDEPEND=">=kde-base/kdesktop-${PV}:${SLOT}"
# 

S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with shadow SHADOW )
		$(cmake-utils_use_with xdmcp XDMCP )
		$(cmake-utils_use_with pam PAM )
	)

	trinity-meta_src_configure
}
