# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta linux-info

DESCRIPTION="An utility to add SAK support to kdm and some other kdm parts."
KEYWORDS=""
IUSE=""

pkg_setup() {
	linux-info_pkg_setup
	if  ! linux_config_exists; then
		ewarn "Can't check the linux kernel configuration."
		ewarn "You might have some incompatible options enabled."
	else
		if ! linux_chkconfig_present INPUT_UINPUT; then
			eerror "${P} requires the INPUT_UINPUT support enabled."
			eerror "Please enable it:"
			eerror "    CONFIG_INPUT_UINPUT=y"
			eerror "in /usr/src/linux/.config or"
			eerror "    Device Drivers --->"
			eerror "        Input device support  --->"
			eerror "           [*] Miscellaneous devices  --->"
			eerror "                < > User level driver support"
		fi
	fi
	trinity-meta_pkg_setup
}
