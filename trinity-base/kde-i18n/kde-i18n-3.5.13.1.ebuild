# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.5.10.ebuild,v 1.9 2009/07/12 11:27:12 armin76 Exp $
EAPI="4"
TRINITY_MODULE_NAME="kde-i18n"

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

src_unpack() {
	local tarball tarfile tarparams f extractlist postfix

	case ${A} in
		*.gz)
			tarparams=" --gzip"
			postfix="gz"
			;;
		*.bz2)
			tarparams=" --bzip2"
			postfix="bz2"
			;;
	esac

	tarfile="${DISTDIR}/${A}"
	topdir="${A%.tar.*}"

	for X in ${LANGS} ; do
		use "linguas_${X}" && extractlist+=" ${topdir}/tde-i18n-${X#linguas_}"
	done

	if [[ -z ${LINGUAS} ]] || [[ -z "${extractlist}" && "${LINGUAS}" != "en" ]]; then
		echo
		ewarn "You either have the LINGUAS environment variable unset or it"
		ewarn "contains languages not supported by trinity-base/kde-i18n."
		ewarn "Because of that, kde-i18n will not add any kind of language"
		ewarn "support."
		ewarn
		ewarn "If you didn't intend this to happen, the available language"
		ewarn "codes are:"
		ewarn "${LANGS}"
		echo
	fi

	extractlist+=" ${topdir}/admin"

	ebegin "Unpacking parts of ${tarball} to ${WORKDIR}"
	tar -xpf "${tarfile}" ${tarparams} -C "${WORKDIR}"  ${extractlist} 2> /dev/null  \
			|| echo "tar extract command failed at least partially - continuing anyway"
}

src_prepare(){
	cp -Rp /usr/share/libtool/config/ltmain.sh "${S}/admin/ltmain.sh"
	cp -Rp /usr/share/aclocal/libtool.m4 "${S}/admin/libtool.m4.in"
	for dir in $(ls -d "${S}"/tde-i18n-*); do
		einfo "Preparing $dir"
		cd "$dir" && emake -f "admin/Makefile.common";
	done
}

src_configure() {
	PREFIX="${TDEDIR}"
	for dir in $(ls -d "${S}"/tde-i18n-*); do
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
	for dir in $(ls -d "${S}"/tde-i18n-*); do
		einfo "Compiling $dir"
		cd "${dir}" && emake;
	done
}

src_install() {
	for dir in $(ls -d "${S}"/tde-i18n-*); do
		einfo "Installing $dir"
		cd "${dir}" && emake install DESTDIR="${D}"
	done
}
