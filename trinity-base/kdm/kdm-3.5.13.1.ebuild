# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity login manager, similar to xdm and gdm"
KEYWORDS="x86 amd64"
IUSE="+shadow pam +xdmcp"

DEPEND="pam? ( kde-base/kdebase-pam )
	xdmcp? ( x11-libs/libXdmcp )
	sys-apps/dbus
	x11-libs/libXau
	x11-libs/libXtst
	>=trinity-base/kcontrol-${PV}:${SLOT}"
	# Requires the desktop background settings and kdm kcontrol modules
RDEPEND="${DEPEND}
	>=trinity-base/kdepasswd-${PV}:${SLOT}
	x11-apps/xinit
	x11-apps/xmessage"
# PDEPEND=">=kde-base/kdesktop-${PV}:${SLOT}"
# 

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with shadow SHADOW )
		$(cmake-utils_use_with xdmcp XDMCP )
		$(cmake-utils_use_with pam PAM )
	)

	trinity-meta_src_configure
}

src_install() {
	cmake-utils_src_install

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${TDEDIR}/share/config/kdm/kdmrc" || die "sed kdmrc failed"

	# install XSession upstream script seems to be debian-cpecific
	cp ${FILESDIR}/${P}-xsession.script "${D}/${TDEDIR}/share/config/kdm/Xsession"
	
}

pkg_postinst() {
	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${TDEDIR}/share/apps/kdm/faces/.default.face.icon" ];	then
		mkdir -p "${ROOT}${TDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${TDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${TDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${TDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${TDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${TDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${TDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
