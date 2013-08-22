# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdeutils"

inherit trinity-meta

DESCRIPTION="kded module that can support various types of hardware input devices, such as those on keyboards."
KEYWORDS=""
IUSE="asus-laptop dell-laptop powerbook-laptop thinkpad-laptop vaio-laptop lm_sensors"

DEPEND="powerbook-laptop? ( app-laptop/pbbuttonsd )"
RDEPEND="${DEPEND}
	lm_sensors? ( sys-apps/lm_sensors )"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with asus-laptop ASUS)
		$(cmake-utils_use_with dell-laptop I8K)
		$(cmake-utils_use_with powerbook-laptop POWERBOOK2)
		$(cmake-utils_use_with thinkpad-laptop THINKPAD)
		$(cmake-utils_use_with vaio-laptop VAIO)
		$(cmake-utils_use_with lm_sensors SENSORS)
	)

	trinity-meta_src_configure
}
