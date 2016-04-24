# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="3"
TRINITY_MODULE_NAME="kdenetwork"

inherit trinity-meta

DESCRIPTION="kcontrol filesharing config module for NFS, SMB etc"
KEYWORDS="amd64 x86"
IUSE=""

PATCHES=( "${FILESDIR}/kdenetwork-bug1330i2-fix-filesharing-parallel-compilation.patch" )
