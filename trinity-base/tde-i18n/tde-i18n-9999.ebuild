# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tde-i18n"

inherit trinity-base cmake-utils

set-trinityver

DESCRIPTION="Trinity internationalization package"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2"

SLOT="${TRINITY_VER}"
KEYWORDS=""
IUSE=""

DEPEND=">=trinity-base/tdelibs-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

LANGS="af ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et
eu fa fi fr fy ga gl he hi hr hu is it ja kk km ko lt lv mk mn ms
nb nds nl nn pa pl pt pt_BR ro ru rw se sk sl sr sr@Latn ss sv ta te
tg th tr uk uz uz@cyrillic vi wa zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

do_foreach_linguas() {
	local lang dir phase;

	phase=$1

	for lang in ${LINGUAS}; do
		dir="tde-i18n-$lang"
		pushd "$S/$dir"
		CMAKE_USE_DIR="${S}/${dir}"
		BUILD_DIR="${WORKDIR}/${dir}-build"
		trinity-base_${phase}
		popd
	done
}

src_configure() {
	do_foreach_linguas src_prepare
}

src_configure() {
	mycmakeargs=( -DBUILD_ALL=ON )
	do_foreach_linguas src_configure
}

src_compile() {
	do_foreach_linguas src_compile
}

src_install() {
	do_foreach_linguas src_install
}
