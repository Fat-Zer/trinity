# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity gui for su(1) or sudo"
KEYWORDS="x86 amd64"
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
