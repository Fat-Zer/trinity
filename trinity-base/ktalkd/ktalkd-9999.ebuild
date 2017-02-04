# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity talk daemon"
KEYWORDS=
IUSE=""

RDEPEND="|| ( net-misc/netkit-talk net-misc/ytalk sys-freebsd/freebsd-ubin )"

pkg_postinst() {
	trinity-meta_pkg_postinst

	if has_version net-misc/ytalk ; then
		elog "To use net-misc/ytalk as your local network chat program, please"
		elog "configure your system accordingly, either via the KDE control center"
		elog "or by calling \"kcmshell kcmktalkd\" on the command line."
	fi
}
