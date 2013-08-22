# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="kdepim"

inherit trinity-meta

DESCRIPTION="Common library for Trinity PIM applications."
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=trinity-base/ktnef-${PV}:${SLOT}
	>=trinity-base/libkmime-${PV}:${SLOT}
	>=trinity-base/libkcal-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libemailfunctions/
	pixmaps/
	libkmime/kmime_util.h
	libkcal/"

src_prepare() {
	trinity-meta_src_prepare
	# Call Qt 3 designer
	sed -i -e "s:\"designer\":\"${QTDIR}/bin/designer\":g" "${S}/libkdepim/kcmdesignerfields.cpp" || die "sed failed"
}
