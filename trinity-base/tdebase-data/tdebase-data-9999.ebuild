# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

TRINITY_SUBMODULE="l10n pics applnk"

DESCRIPTION="Icons, localization data and .desktop files from kdebase. Includes l10n, pics and applnk subdirs."
KEYWORDS=""
IUSE="doc"

pkg_setup() {
	use doc && TRINITY_SUBMODULE+=" doc"
	trinity-meta_pkg_setup;
}
