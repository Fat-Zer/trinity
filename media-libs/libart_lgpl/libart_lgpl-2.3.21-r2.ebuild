# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2

DESCRIPTION="a LGPL version of libart"
HOMEPAGE="http://www.levien.com/libart"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/pkgconfig"

# The provided tests are interactive only
RESTRICT="test"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# Fix crosscompiling, bug #185684
	rm "${S}"/art_config.h
	# NOTE patch is removed automake should handle it

	# Do not build tests if not required
	epatch "$FILESDIR/0001-gentoo-do-not-build-tests-if-not-required.patch"

	# apply TDE patches
	epatch "$FILESDIR/0002-TDE-fix-a-number-of-problems.patch"
	epatch "$FILESDIR/0003-TDE-Clean-up-debug-spew.patch"

	# apply user-provided patches
	epatch_user

	AT_NOELIBTOOLIZE=yes eautoreconf
}
