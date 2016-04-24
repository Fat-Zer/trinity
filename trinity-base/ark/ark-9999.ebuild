# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdeutils"

inherit trinity-meta

DESCRIPTION="Trinity Archiving tool"
KEYWORDS=""
IUSE=""

pkg_postinst(){
	elog "You may want to install app-arch/lha, app-arch/p7zip, app-arch/rar,"
	elog "app-arch/zip or app-arch/zoo for support of these archive types."
}
