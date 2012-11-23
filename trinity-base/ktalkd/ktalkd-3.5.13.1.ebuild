# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="Trinity talk daemon"
KEYWORDS="amd64 x86"
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
