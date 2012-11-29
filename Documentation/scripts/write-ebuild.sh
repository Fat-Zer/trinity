#!/bin/bash
HEADER="# Copyright 1999-$(date +%Y) Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# \$Header: \$"
EAPI="4"

TRINITY_MODULE_NAME=$1
PN=$2
DESCRIPTION="$3"
PV=${PV:=3.5.13.1}
KEYWORDS="amd64 x86"
case "${PV}" in
	*9999*) KEYWORDS="" ;;
esac

echo "==> Creating ebuild for ${PN}-${PV}"
if [ -z "$DESCRIPTION" ]; then
	DESCRIPTION="$(eix -C kde-base -s "${PN}" | sed -n '/^\s*Description:\s*/{s///;s/\(\<KDE\|\kde\)\>/Trinity/g;p}')"
	echo -n "DESCRIPTION [${DESCRIPTION}]:" && read dsc
	[ -n "$dsc" ] && DESCRIPTION="$dsc"
fi


mkdir -p trinity-base/$PN
cat <<EOF >trinity-base/$PN/$PN-${PV}.ebuild
$HEADER
EAPI="$EAPI"
TRINITY_MODULE_NAME="$TRINITY_MODULE_NAME"

inherit trinity-meta

DESCRIPTION="$DESCRIPTION"
KEYWORDS="$KEYWORDS"
IUSE=""
EOF

cat <<EOF >trinity-base/$PN/metadata.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE pkgmetadata SYSTEM "http://www.gentoo.org/dtd/metadata.dtd">
<pkgmetadata>
	<maintainer>
		<email>fatzer2@gmail.com</email>
		<name>Golubev Alexander</name>
	</maintainer>
</pkgmetadata>
EOF

if [ -d eclass/trinity-shared-files/${TRINITY_MODULE_NAME}-${PV} ]; then
	mkdir -p "trinity-base/$PN/files/"
	ln -s "../../../eclass/trinity-shared-files/" "trinity-base/$PN/files/shared"
fi
