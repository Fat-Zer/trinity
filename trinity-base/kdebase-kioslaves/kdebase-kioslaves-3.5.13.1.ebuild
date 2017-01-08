# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

TSM_EXTRACT="kioslave"

DESCRIPTION="Generic Trinity KIOslaves"
KEYWORDS="x86 amd64"
IUSE="hal ldap openexr samba sasl"

DEPEND="
	x11-libs/libXcursor
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	samba? ( net-fs/samba )
	ldap? ( net-nds/openldap )
	sasl? ( dev-libs/cyrus-sasl:2 )
	hal? ( dev-libs/dbus-tqt =sys-apps/hal-0.5* )"

RDEPEND="${DEPEND}
	virtual/ssh
	trinity-base/kdeeject:${SLOT}"

PATCHES=( "${FILESDIR}/${TRINITY_MODULE_NAME}-3.5.13.1-fix-kioslaves-with-hal.patch" )

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSOR=ON
		$(cmake-utils_use_with hal HAL)
		$(cmake-utils_use_with ldap LDAP)
		$(cmake-utils_use_with openexr OPENEXR)
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with sasl SASL)
	)

	trinity-meta_src_configure
}
