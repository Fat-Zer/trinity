# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="The Trinity Address Book"
KEYWORDS=""
IUSE+=" gnokii"

COMMON_DEPEND=">=trinity-base/libtdepim-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}
	>=trinity-base/certmanager-${PV}:${SLOT}
	>=trinity-base/libtdenetwork-${PV}:${SLOT}
	gnokii? ( app-mobilephone/gnokii )"

DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="certmanager/lib/
	libtdepim/
	libtdenetwork/
	libkcal/
	libemailfunctions/"

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with gnokii GNOKII )
	)
	trinity-meta_src_configure
}
