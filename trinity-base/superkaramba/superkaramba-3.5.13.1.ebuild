# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="A tool to create interactive applets for the Trinity desktop."
KEYWORDS="x86 amd64"
#FIXME: add xmms use
IUSE=""

# RDEPEND="xmms? (media-sound/xmms2)"

src_configure() {
	mycmakeargs=(
#		$(cmake-utils_use_with xmms XMMS )
		"-DWITH_XMMS=ON"
		"-DWITH_KNEWSTUFF=ON"
	)

	trinity-meta_src_configure
}
