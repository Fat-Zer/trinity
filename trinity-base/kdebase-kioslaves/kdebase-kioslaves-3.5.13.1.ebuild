# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

TRINITY_SUBMODULE="kioslaves"
# KMEXTRACT="kioslave"

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS="x86 amd64"
IUSE="samba ldap sasl openexr"

DEPEND="
	x11-libs/libXcursor
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	samba? ( net-fs/samba )
	ldap? ( net-nds/openldap )
	sasl? ( dev-libs/cyrus-sasl )
	x11-apps/xhost"

RDEPEND="${DEPEND}"
# CHECKME: optional dependencies
#DEPEND="
#	>=dev-libs/cyrus-sasl-2
#	hal? ( dev-libs/dbus-qt3-old =sys-apps/hal-0.5* )"

RDEPEND="${DEPEND}
	virtual/ssh
	trinity-base/kdeeject:${SLOT}"

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSOR=ON
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with ldap LDAP)
		$(cmake-utils_use_with sasl SASL)
		$(cmake-utils_use_with openexr OPENEXR)
	)

	trinity-meta_src_configure
}
