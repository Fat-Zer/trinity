# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="x86 amd64"
IUSE="pam"

RDEPEND="
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pam PAM)
	)

	trinity-meta_src_configure
}
