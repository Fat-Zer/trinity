#!/bin/bash
# Usage ; write-ebuild.sh <TRINITY_MODULE_NAME> [<CATEGORY/]><PN> [DESCRIPTION]
export LC_ALL=C

HEADER="# Copyright 1999-$(date +%Y) Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# \$Id:\$"
EAPI="5"

TRINITY_MODULE_NAME=$1
PN=$(basename ${2})
CATEGORY=$(dirname ${2})
CATEGORY=${CATEGORY:-trinity-base}
DESCRIPTION="$3"

PV=${PV:=9999}
KEYWORDS="amd64 x86"
case "${PV}" in
	*3.5.13.2) KEYWORDS="~amd64 ~x86" ;;
	*9999*) KEYWORDS="" ;;
esac

if [ -z "$DESCRIPTION" ]; then
    DESCRIPTION_SOURCES=( ${CATEGORY/trinity/kde}/${PN}  ${CATEGORY/trinity/kde}/${PN/k/t} kde-base/${PN} kde-base/${PN/k/t} )
    for descsrc in ${DESCRIPTION_SOURCES[@]}; do
        DESCRIPTION="$(eix -C $(dirname ${descsrc}) -s $(basename "${descsrc}") | sed -n '/^\s*Description:\s*/{s///;s/\(\<KDE\|\kde\)\>/Trinity/g;p}')"
        [ -n "$DESCRIPTION" ] && break
    done
fi

echo "==> Creating ebuild for ${PN}-${PV}"

mkdir -p "${CATEGORY}/$PN"

cat <<EOF >${CATEGORY}/$PN/$PN-${PV}.ebuild
$HEADER
EAPI="$EAPI"
TRINITY_MODULE_NAME="$TRINITY_MODULE_NAME"

inherit trinity-meta

DESCRIPTION="$DESCRIPTION"
KEYWORDS="$KEYWORDS"
IUSE+=""
EOF

cat <<EOF >"${CATEGORY}/$PN"/metadata.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE pkgmetadata SYSTEM "http://www.gentoo.org/dtd/metadata.dtd">
<pkgmetadata>
	<maintainer type="person">
		<email>fatzer2@gmail.com</email>
		<name>Alexander Golubev</name>
	</maintainer>
</pkgmetadata>
EOF

if [ -d eclass/trinity-shared-files/${TRINITY_MODULE_NAME}-${PV} ]; then
	mkdir -p "${CATEGORY}/$PN/files/"
	ln -s "../../../eclass/trinity-shared-files/" "trinity-base/$PN/files/shared"
fi
