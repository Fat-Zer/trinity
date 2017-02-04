# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="Trinity system monitoring applets."
KEYWORDS="x86 amd64"
IUSE="snmp lm_sensors dell-laptop"

DEPEND="lm_sensors? ( x11-libs/libXext )
	snmp? ( net-analyzer/net-snmp )"
RDEPEND="${DEPEND}
	lm_sensors? ( sys-apps/lm_sensors )"
PATCHES=( "$FILESDIR/fix_crash.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with dell-laptop I8K)
		$(cmake-utils_use_with snmp SNMP)
		$(cmake-utils_use_with lm_sensors SENSORS)
	)

	trinity-meta_src_configure
}
