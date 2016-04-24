# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdepim"

inherit trinity-meta

DESCRIPTION="The Trinity Address Book"
KEYWORDS="~amd64 ~x86"
IUSE+=" gnokii"

COMMON_DEPEND=">=trinity-base/libkdepim-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}
	>=trinity-base/certmanager-${PV}:${SLOT}
	>=trinity-base/libkdenetwork-${PV}:${SLOT}
	gnokii? ( app-mobilephone/gnokii )"

DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="certmanager/lib/
	libkdepim/
	libkdenetwork/
	libkcal/
	libemailfunctions/"

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with gnokii GNOKII )
	)
	trinity-meta_src_configure
}
