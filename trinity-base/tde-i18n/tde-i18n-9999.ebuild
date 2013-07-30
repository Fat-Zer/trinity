# Copyright 1999-2
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.5.10.ebuild,v 1.9 2009/07/12 11:27:12 armin76 Exp $
EAPI="4"
TRINITY_MODULE_NAME="tde-i18n"

inherit eutils trinity-base

set-trinityver

DESCRIPTION="Trinity internationalization package"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2"

SLOT="${TRINITY_VER}"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	sys-devel/libtool
	>=sys-devel/automake-1.10.1"
RDEPEND=""

LANGS="af ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et
eu fa fi fr fy ga gl he hi hr hu is it ja kk km ko lt lv mk mn ms
nb nds nl nn pa pl pt pt_BR ro ru rw se sk sl sr sr@Latn ss sv ta te
tg th tr uk uz uz@cyrillic vi wa zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_prepare(){
	local lang dir;
	cp -Rp /usr/share/libtool/config/ltmain.sh "${S}/admin/ltmain.sh"
	cp -Rp /usr/share/aclocal/libtool.m4 "${S}/admin/libtool.m4.in"
	for lang in ${LINGUAS}; do
		dir="tde-i18n-$lang"
		[[ -d $dir ]] || continue;
		einfo "Preparing $dir"
		cd "$dir" && emake -f "admin/Makefile.common";
	done
}

src_configure() {
	PREFIX="${TDEDIR}"
	for lang in ${LINGUAS}; do
		dir="tde-i18n-$lang"
		[[ -d $dir ]] || continue;
		einfo "Configuring $dir"
		cd "${dir}" && econf \
			--without-arts \
			--prefix="${PREFIX}" \
			--mandir="${PREFIX}/share/man"\
			--infodir="${PREFIX}/share/info" \
			--datadir="${PREFIX}/share" \
			--sysconfdir="${PREFIX}/etc"
	done
}

src_compile() {
	for lang in ${LINGUAS}; do
		dir="tde-i18n-$lang"
		[[ -d $dir ]] || continue;
		einfo "Compiling $dir"
		cd "${dir}" && emake;
	done
}

src_install() {
	for lang in ${LINGUAS}; do
		dir="tde-i18n-$lang"
		[[ -d $dir ]] || continue;
		einfo "Installing $dir"
		cd "${dir}" && emake install DESTDIR="${D}"
	done
}
