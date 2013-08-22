# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta

DESCRIPTION="library common to many tdepim apps interacting to network"
KEYWORDS=""
IUSE+=""

COMMON_DEPEND=">=app-crypt/gpgme-1.0.2"
DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"
