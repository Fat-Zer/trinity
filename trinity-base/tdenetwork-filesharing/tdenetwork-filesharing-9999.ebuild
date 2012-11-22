# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta

DESCRIPTION="kcontrol filesharing config module for NFS, SMB etc"
KEYWORDS=""
IUSE=""

PATCHES=( "${FILESDIR}/tdenetwork-bug1330i2-fix-filesharing-parallel-compilation.patch" )
