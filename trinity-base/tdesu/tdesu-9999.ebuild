# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity gui for su(1) or sudo"
KEYWORDS=""
IUSE="sudo"

DEPEND+=" sudo? ( app-admin/sudo )"
RDEPEND+=" ${DEPEND}"

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with sudo SUDO_KDESU_BACKEND)
	)

	trinity-meta_src_configure
}

pkg_postinst () {
	if use sudo; then
		einfo "Remember sudo use flag sets only the defauld value"
		einfo "It can be overriden on a user-level by adding:"
		einfo "  [super-user-command]"
		einfo "    super-user-command=su"
		einfo "To the kdeglobal config file which is should be usually"
		einfo "located in the ~/.trinity/share/config/ directory."
	fi
}
