# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdenetwork"
TRINITY_SUBMODULE="lanbrowsing"
inherit trinity-meta

DESCRIPTION="Trinity Lan Information Server - allows to share information over a network."
KEYWORDS="amd64 x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/lisa-3.5.13.1-6f85c0c-fix-references-to-user-profile-directory.patch" )

src_install() {
	trinity-meta_src_install

	chmod u+s "${D}/${KDEDIR}/bin/reslisa"

	# lisa, reslisa initscripts
	sed -e "s:_TDEDIR_:${TDEDIR}:g" "${FILESDIR}/lisa" > "${T}/lisa"
	sed -e "s:_TDEDIR_:${TDEDIR}:g" "${FILESDIR}/reslisa" > "${T}/reslisa"
	doinitd "${T}/lisa" "${T}/reslisa"

	newconfd "${FILESDIR}/lisa.conf" lisa
	newconfd "${FILESDIR}/reslisa.conf" reslisa

	echo '# Default lisa configfile' > "$D/etc/lisarc"
	echo '# Default reslisa configfile' > "$D/etc/reslisarc"
}
