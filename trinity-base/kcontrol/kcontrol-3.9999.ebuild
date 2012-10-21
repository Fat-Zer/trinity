# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta
KMEXTRACTALSO="kicker kwin kdesktop klipper kxkb"

DESCRIPTION="The Trinity Control Center"
KEYWORDS=""
IUSE="samba logitech-mouse ieee1394"

SLOT="3.5"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXcursor
	x11-libs/libXrandr
	dev-libs/openssl
	samba? ( net-fs/samba )
	logitech-mouse? ( virtual/libusb:0 )
	ieee1394? ( sys-libs/libraw1394 )
	trinity-base/tdelibs:${SLOT}
	>=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kicker-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	>=trinity-base/kcminit-${PV}:${SLOT}
	>=trinity-base/tdebase-data-${PV}:${SLOT}
	>=trinity-base/tdesu-${PV}:${SLOT}
	>=trinity-base/khelpcenter-${PV}:${SLOT}
	>=trinity-base/khotkeys-${PV}:${SLOT}"

# possible dependecies CHECKME
# DEPEND="
#	>=media-libs/freetype-2.3
#	media-libs/fontconfig"
# RDEPEND="${DEPEND}

# S=${WORKDIR}/kdebase

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSOR=ON
		-DWITH_XRANDR=ON
		-DWITH_USBIDS=/usr/share/misc/usb.ids
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with logitech-mouse LIBUSB)
		$(cmake-utils_use_with ieee1394 LIBRAW1394)
	)

	trinity-meta_src_configure
}
