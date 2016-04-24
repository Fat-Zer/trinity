# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="Common library for Trinity PIM applications."
KEYWORDS=""
IUSE+=""

COMMON_DEPEND="
	>=trinity-base/ktnef-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}"
DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="libemailfunctions/
	pixmaps/
	libkmime/kmime_util.h
	libkcal/"

src_prepare() {
	trinity-meta_src_prepare
	# Call Qt 3 designer
	sed -i -e "s:\"designer\":\"${QTDIR}/bin/designer\":g" "${S}/libtdepim/kcmdesignerfields.cpp" || die "sed failed"
}
