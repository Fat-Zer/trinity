# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

TSM_EXTRACT_ALSO="tsak"

DESCRIPTION="Trinity login manager, similar to xdm and gdm"
KEYWORDS=""
IUSE="pam xdmcp xcomposite"

DEPEND="pam? ( kde-base/kdebase-pam )
	xdmcp? ( x11-libs/libXdmcp )
	xcomposite? ( x11-libs/libXcomposite )
	sys-apps/dbus
	x11-libs/libXrandr
	x11-libs/libXtst
	>=trinity-base/kcontrol-${PV}:${SLOT}
	dev-libs/dbus-tqt"

RDEPEND="${DEPEND}
	>=trinity-base/kdepasswd-${PV}:${SLOT}
	x11-apps/xinit
	x11-apps/xmessage"

pkg_setup() {
	trinity-meta_pkg_setup;
	use tsak && TRINITY_SUBMODULE+=" tsak"
}

src_configure() {
	mycmakeargs=(
		-DWITH_XTEST=ON
		-DWITH_LIBART=ON
		-DWITH_XRANDR=ON
		-DWITH_SHADOW=ON
		$(cmake-utils_use_with xcomposite XCOMPOSITE )
		$(cmake-utils_use_with xdmcp XDMCP )
		$(cmake-utils_use_with pam PAM )
	)

	trinity-meta_src_configure
}

src_install() {
	cmake-utils_src_install

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${TDEDIR}/share/config/tdm/tdmrc" || die "sed tdmrc failed"

}

pkg_postinst() {
	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${TDEDIR}/share/apps/tdm/faces/.default.face.icon" ];	then
		mkdir -p "${ROOT}${TDEDIR}/share/apps/tdm/faces"
		cp "${ROOT}${TDEDIR}/share/apps/tdm/pics/users/default1.png" \
			"${ROOT}${TDEDIR}/share/apps/tdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${TDEDIR}/share/apps/tdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${TDEDIR}/share/apps/tdm/faces"
		cp "${ROOT}${TDEDIR}/share/apps/tdm/pics/users/root1.png" \
			"${ROOT}${TDEDIR}/share/apps/tdm/faces/root.face.icon"
	fi
}
