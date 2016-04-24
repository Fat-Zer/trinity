# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeutils"

inherit trinity-meta

DESCRIPTION="Trinity system monitoring applets."
KEYWORDS=""
IUSE="snmp lm_sensors dell-laptop"

DEPEND="lm_sensors? ( x11-libs/libXext )
	snmp? ( net-analyzer/net-snmp )"
RDEPEND="${DEPEND}
	lm_sensors? ( sys-apps/lm_sensors )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with dell-laptop I8K)
		$(cmake-utils_use_with snmp SNMP)
		$(cmake-utils_use_with lm_sensors SENSORS)
	)

	trinity-meta_src_configure
}
