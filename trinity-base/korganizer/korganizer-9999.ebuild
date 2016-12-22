# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="A Personal Organizer for Trinity"
KEYWORDS=""
IUSE+=" exchange"
COMMON_DEPEND="
	>=trinity-base/kgantt-${PV}:${SLOT}
	>=trinity-base/libtdepim-${PV}:${SLOT}
	>=trinity-base/libtdenetwork-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}
	>=trinity-base/ktnef-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}
	>=trinity-base/libkholidays-${PV}:${SLOT}
	>=trinity-base/certmanager-${PV}:${SLOT}
	>=trinity-base/libkpimidentities-${PV}:${SLOT}
	>=trinity-base/kaddressbook-${PV}:${SLOT}
	exchange? ( >=trinity-base/libkpimexchange-${PV}:${SLOT} )"
#	>=trinity-base/tdepim-tderesources-${PV}:${SLOT}

DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="certmanager/lib/
	libemailfunctions/
	libkcal/
	libkholidays/
	libkpimidentities/
	libtdepim/
	libkmime/
	kdgantt/
	kmail/"

TSM_EXTRACT_ALSO+=" libkpimexchange/core/" # required for USE=exchange

src_configure () {
	mycmakeargs=(
		$(cmake-utils_use_with exchange EXCHANGE )
	)
	trinity-meta_src_configure
}
