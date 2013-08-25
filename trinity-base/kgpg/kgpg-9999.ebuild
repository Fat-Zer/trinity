# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdeutils"

inherit trinity-meta

DESCRIPTION="Trinity gpg keyring manager"
KEYWORDS=""
IUSE=""

RDEPEND="app-crypt/gnupg
	|| ( app-crypt/pinentry[qt4]
		app-crypt/pinentry[gtk]
		app-crypt/pinentry[qt3] )"
