# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_install() {
	emake DESTDIR="${D}" install || die
}
