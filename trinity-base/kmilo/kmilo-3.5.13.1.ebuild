# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="kded module that can support various types of hardware input devices, such as those on keyboards."
KEYWORDS="x86 amd64"
IUSE="asus dell powerbook thinkpad vaio lm_sensors"

DEPEND="powerbook? ( app-laptop/pbbuttonsd )"
RDEPEND="${DEPEND}
	lm_sensors? ( sys-apps/lm_sensors )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with asus ASUS)
		$(cmake-utils_use_with dell I8K)
		$(cmake-utils_use_with powerbook POWERBOOK2)
		$(cmake-utils_use_with thinkpad THINKPAD)
		$(cmake-utils_use_with vaio VAIO)
		$(cmake-utils_use_with lm_sensors SENSORS)
	)

	trinity-meta_src_configure
}
