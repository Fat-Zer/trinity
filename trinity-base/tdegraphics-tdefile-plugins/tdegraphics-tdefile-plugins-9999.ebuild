# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="kfile plugins from kdegraphics"
KEYWORDS=
IUSE="tiff openexr pdf"

DEPEND="
	tiff? ( media-libs/tiff:= )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	pdf? ( app-text/poppler )"
RDEPEND="$DEPEND"

TSM_EXTRACT_ALSO="kghostview/dscparse/"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with openexr OPENEXR)
		$(cmake-utils_use_with pdf PDF)
	)

	trinity-meta_src_configure
}
