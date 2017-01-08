# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeartwork"

inherit trinity-meta
KMMODULE="IconThemes"

DESCRIPTION="Icon themes for Trinity"
KEYWORDS=
IUSE=""

TSM_EXTRACT="IconThemes/"

src_prepare() {
	trinity-meta_src_prepare

	# file collision with trinity-base/kicker-applets
	# see: https://bugs.trinitydesktop.org/show_bug.cgi?id=1282
	rm -f IconThemes/locolor/16x16/apps/ktimemon.png
	rm -f IconThemes/locolor/32x32/apps/ktimemon.png
}
