# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="The Trinity Control Center"
KEYWORDS=
IUSE="samba logitech-mouse ieee1394 +xrandr"

DEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXcursor
	samba? ( net-fs/samba )
	logitech-mouse? ( virtual/libusb:0 )
	ieee1394? ( sys-libs/libraw1394 )
	xrandr? ( x11-libs/libXrandr )
	>=trinity-base/tdelibs-${PV}:${SLOT}[xrandr?]
	>=trinity-base/libkonq-${PV}:${SLOT}
	>=trinity-base/kicker-${PV}:${SLOT}"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	>=trinity-base/kcminit-${PV}:${SLOT}
	>=trinity-base/tdebase-data-${PV}:${SLOT}
	>=trinity-base/tdesu-${PV}:${SLOT}
	>=trinity-base/khelpcenter-${PV}:${SLOT}
	>=trinity-base/khotkeys-${PV}:${SLOT}"

TSM_EXTRACT_ALSO="kicker/ twin/ kdesktop/ klipper/ kxkb/"

src_configure() {
	mycmakeargs=(
		-DWITH_XCURSOR=ON
		-DWITH_XRENDER=ON
		-DWITH_USBIDS=/usr/share/misc/usb.ids
		$(cmake-utils_use_with samba SAMBA)
		$(cmake-utils_use_with logitech-mouse LIBUSB)
		$(cmake-utils_use_with ieee1394 LIBRAW1394)
		$(cmake-utils_use_with xrandr XRANDR)
	)

	trinity-meta_src_configure
}
