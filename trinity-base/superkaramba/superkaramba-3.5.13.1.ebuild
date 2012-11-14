# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="A tool to create interactive applets for the Trinity desktop."
KEYWORDS="x86 amd64"
#FIXME: add xmms use
IUSE="knewstuff"

# RDEPEND="xmms? (media-sound/xmms2)"

src_configure() {
	mycmakeargs=(
#		$(cmake-utils_use_with xmms XMMS )
		"-DWITH_XMMS=ON"
		$(cmake-utils_use_with knewstuff KNEWSTUFF )
	)

	trinity-meta_src_configure
}
