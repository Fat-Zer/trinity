# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="Trinity Archiving tool"
KEYWORDS="x86 amd64"
IUSE=""

pkg_postinst(){
	elog "You may want to install app-arch/lha, app-arch/p7zip, app-arch/rar,"
	elog "app-arch/zip or app-arch/zoo for support of these archive types."
}
