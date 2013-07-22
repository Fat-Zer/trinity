# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="Trinity login manager, similar to xdm and gdm"
KEYWORDS=""
IUSE="pam xdmcp xcomposite sak xrandr"

DEPEND="pam? ( kde-base/kdebase-pam )
	xdmcp? ( x11-libs/libXdmcp )
	xcomposite? ( x11-libs/libXcomposite )
	xrandr? ( x11-libs/libXrandr )
	>=trinity-base/tdelibs-${PV}:${SLOT}[xrandr?]
	sys-apps/dbus
	x11-libs/libXrandr
	x11-libs/libXtst
	>=trinity-base/kcontrol-${PV}:${SLOT}
	dev-libs/dbus-tqt"

RDEPEND="${DEPEND}
	>=trinity-base/tdepasswd-${PV}:${SLOT}
	x11-apps/xinit
	x11-apps/xmessage"

pkg_setup() {
	trinity-meta_pkg_setup;
	use sak && TRINITY_SUBMODULE+=" tsak"
}

src_configure() {
	mycmakeargs=(
		-DWITH_XTEST=ON
		-DWITH_LIBART=ON
		-DWITH_SHADOW=ON
		$(cmake-utils_use_with xcomposite XCOMPOSITE )
		$(cmake-utils_use_with xdmcp XDMCP )
		$(cmake-utils_use_with xrandr XRANDR )
		$(cmake-utils_use_with pam PAM )
	)

	trinity-meta_src_configure
}

src_install() {
	cmake-utils_src_install

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${TDEDIR}/share/config/tdm/tdmrc" || die "sed tdmrc failed"

	# install XSession upstream script seems to be debian-cpecific
	cp "${FILESDIR}/${P}-xsession.script" "${D}/${TDEDIR}/share/config/tdm/Xsession"

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

	if use sak; then
		sak_ok=yes
		if ! linux_config_exists; then
			ewarn "Can't check the linux kernel configuration."
			ewarn "You might have some incompatible options enabled."
			sak_ok=no
		else
			if ! linux_chkconfig_present INPUT_UINPUT; then
				eerror "You build tdm with sak feature enabled. "
				eerror "It requires the INPUT_UINPUT support enabled."
				eerror "Please enable it:"
				eerror "    CONFIG_INPUT_UINPUT=y"
				eerror "in /usr/src/linux/.config or"
				eerror "    Device Drivers --->"
				eerror "        Input device support  --->"
				eerror "           [*] Miscellaneous devices  --->"
				eerror "                <*> User level driver support"
				sak_ok=no
			fi
		fi
		if [[ "$sak_ok" != yes ]]; then
			sed -i -e 's:#\?\s*UseSAK=\(true\|false\)\?:UseSak=false:' \
				"${D}${TDEDIR}/share/config/tdm/tdmrc" || die "sed tdmrc failed"
			ewarn "SAK feature is disabled. You can enable it yourself by setting UseSAK=true "
			ewarn "in ${TDEDIR}/share/config/tdm/tdmrc "
		else
			ewarn "SAK feature is enabled. You can disable it yourself by setting UseSAK=false"
			ewarn "in ${TDEDIR}/share/config/tdm/tdmrc "
		fi
	fi
}
