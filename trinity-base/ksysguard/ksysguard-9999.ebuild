# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="A network enabled task manager/system monitor"
KEYWORDS=
IUSE=" dell-laptop"
# TODO: make support for sensors when it will be supported by cmake scripts

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with dell-laptop I8K)
	)

	trinity-meta_src_configure
}
