# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdetoys"

inherit trinity-meta

DESCRIPTION="Documentaion for kdetoys-derived packages"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="
	>=trinity-base/khelpcenter-${PV}:${SLOT}"

pkg_setup() {
	# we should reduce MAKEOPTS -j parametr to no more than 4
	local makeopts_j
	makeopts_j="$(echo "$MAKEOPTS" | sed -n 's/\(^\|.*\s\)\(-j\s*[0-9]\+\)\(\s.*\|$\)/\2/p')"
	if [ -n "$makeopts_j" -a "$makeopts_j" > 4 ]; then
		export MAKEOPTS="${MAKEOPTS//"${makeopts_j}"/-j4}"

		ewarn "This ebuild needs huge amoumt of memmory to compile in highly parallel"
		ewarn "mode so it can chew it all. MAKEOPTS are reduced to \"$MAKEOPTS\"."
	fi

	trinity-meta_pkg_setup
}
