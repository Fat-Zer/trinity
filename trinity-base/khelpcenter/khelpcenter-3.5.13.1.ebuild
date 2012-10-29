# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta
TRINITY_SUBMODULE="khelpcenter doc"

DESCRIPTION="The Trinity help center."
KEYWORDS="x86 amd64"

RDEPEND="
	>=trinity-base/kdebase-kioslaves-${PV}:${SLOT}
	>=www-misc/htdig-3.2.0_beta6-r1"
IUSE=""

pkg_setup() {
	# we should reduce MAKEOPTS -j parametr to no more than 4
	local makeopts_j
	makeopts_j="$(echo "$MAKEOPTS" | sed -n 's/\(^\|.*\s\)\(-j\s*[0-9]\+\)\(\s.*\|$\)/\2/p')"
	if [ -n "$makeopts_j" -a "$makeopts_j" > 4 ]; then
		export MAKEOPTS="${MAKEOPTS//"${makeopts_j}"/-j4}"

		ewarn "This ebuild needs huge amoumt of memmory to compile in highly"
		ewarn "parallel mode so it can chew it all. "
		ewarn "MAKEOPTS are reduced to '$MAKEOPTS'."
	fi

	trinity-meta_pkg_setup
}
