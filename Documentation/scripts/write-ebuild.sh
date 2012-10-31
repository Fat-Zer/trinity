#!/bin/bash
HEADER="# Copyright 1999-$(date +%Y) Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# \$Header: \$"
EAPI="3"
KEYWORDS="x86 amd64"

TRINITY_MODULE_NAME=$1
PV=$2
DESCRIPTION="$3"

echo "==> Creating ebuild for ${PV}"
if [ -z "$DESCRIPTION" ]; then
	DESCRIPTION="$(eix -C kde-base -s "${PV}" | sed -n '/^\s*Description:\s*/{s///;s/\(\<KDE\|\kde\)\>/Trinity/g;p}')"
	echo -n "DESCRIPTION [${DESCRIPTION}]:" && read dsc
	[ -n "$dsc" ] && DESCRIPTION="$dsc"
fi


mkdir -p trinity-base/$PV
cat <<EOF >trinity-base/$PV/$PV-3.5.13.1.ebuild
$HEADER
EAPI="$EAPI"
TRINITY_MODULE_NAME="$TRINITY_MODULE_NAME"

inherit trinity-meta

DESCRIPTION="$DESCRIPTION"
KEYWORDS="$KEYWORDS"
IUSE=""
EOF

cat <<EOF >trinity-base/$PV/metadata.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE pkgmetadata SYSTEM "http://www.gentoo.org/dtd/metadata.dtd">
<pkgmetadata>
	<maintainer>
		<email>fatzer2@gmail.com</email>
		<name>Golubev Alexander</name>
	</maintainer>
</pkgmetadata>
EOF
