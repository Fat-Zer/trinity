# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="2"
inherit trinity-meta

DESCRIPTION="KDE: gui for su(1) or sudo"
KEYWORDS=""
IUSE="sudo"
#
DEPEND+="
	sudo? ( app-admin/sudo )"
RDEPEND+=" ${DEPEND}"

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with sudo SUDO_KDESU_BACKEND)
	)

	trinity-meta_src_configure
}
