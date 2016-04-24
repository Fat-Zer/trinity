# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="Trinity gpg keyring manager"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="app-crypt/gnupg
	|| ( app-crypt/pinentry[qt4]
		app-crypt/pinentry[gtk]
		app-crypt/pinentry[qt3] )"
