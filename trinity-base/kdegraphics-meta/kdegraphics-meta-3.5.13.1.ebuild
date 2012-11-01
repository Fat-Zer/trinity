# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"

inherit trinity-functions

set-trinityver

DESCRIPTION="kdegraphics metapackage - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="${TRINITY_VER}"
IUSE=""
KEYWORDS="amd64 x86"

RDEPEND="
	>=trinity-base/kamera-${PV}:${SLOT}
	>=trinity-base/kcoloredit-${PV}:${SLOT}
	>=trinity-base/kdvi-${PV}:${SLOT}
	>=trinity-base/kfax-${PV}:${SLOT}
	>=trinity-base/kdegraphics-kfile-plugins-${PV}:${SLOT}
	>=trinity-base/kgamma-${PV}:${SLOT}
	>=trinity-base/kghostview-${PV}:${SLOT}
	>=trinity-base/kiconedit-${PV}:${SLOT}
	>=trinity-base/kmrml-${PV}:${SLOT}
	>=trinity-base/kolourpaint-${PV}:${SLOT}
	>=trinity-base/kooka-${PV}:${SLOT}
	>=trinity-base/kpdf-${PV}:${SLOT}
	>=trinity-base/kpovmodeler-${PV}:${SLOT}
	>=trinity-base/kruler-${PV}:${SLOT}
	>=trinity-base/ksnapshot-${PV}:${SLOT}
	>=trinity-base/ksvg-${PV}:${SLOT}
	>=trinity-base/kuickshow-${PV}:${SLOT}
	>=trinity-base/kview-${PV}:${SLOT}
	>=trinity-base/kviewshell-${PV}:${SLOT}
	>=trinity-base/libkscan-${PV}:${SLOT}"
