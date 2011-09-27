# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.5.10.ebuild,v 1.9 2009/07/12 11:27:12 armin76 Exp $

EAPI="1"
WANT_AUTOMAKE="1.10"

inherit eutils kde

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

SLOT="${KDEMAJORVER}.${KDEMINORVER}"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-devel/automake-1.10.1"
RDEPEND=""

need-kde ${PV}
LANGS="af ar az bg bn br bs ca cs csb cy da de el en_GB eo es et
eu fa fi fr fy ga gl he hi hr hu is it ja kk km ko lt lv mk
mn ms nb nds nl nn pa pl pt pt_BR ro ru rw se sk sl sr
sr@Latn ss sv ta te tg th tr uk uz uz@cyrillic vi wa zh_CN zh_TW"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/stable/${PV}/src/kde-i18n/kde-i18n-${X}-${PV}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	if [[ -z ${LINGUAS} ]] || [[ -z ${A} && "${LINGUAS}" != "en" ]]; then
		echo
		ewarn "You either have the LINGUAS environment variable unset or it"
		ewarn "contains languages not supported by kde-base/kde-i18n."
		ewarn "Because of that, kde-i18n will not add any kind of language"
		ewarn "support."
		ewarn
		ewarn "If you didn't intend this to happen, the available language"
		ewarn "codes are:"
		ewarn "${LANGS}"
		echo
	fi

	# Override kde_src_unpack.
	[[ -n ${A} ]] && unpack ${A}

	# Work around KDE bug 126311.
	for dir in $(ls "${WORKDIR}"); do
		lang=$(echo ${dir} | cut -f3 -d-)

		[[ -e "${WORKDIR}/${dir}/docs/common/Makefile.in" ]] || continue
		sed -e "s:\$(KDE_LANG)/${lang}/:\$(KDE_LANG)/:g" \
			-i "${WORKDIR}/${dir}/docs/common/Makefile.in" || die "Failed to fix ${lang}."
	done
}

src_compile() {
	for dir in $(ls "${WORKDIR}"); do
		KDE_S="${WORKDIR}/${dir}"
		kde_src_compile myconf
		myconf="${myconf} --prefix=${KDEDIR}"
		kde_src_compile configure
		kde_src_compile make
	done
}

src_install() {
	for dir in $(ls "${WORKDIR}"); do
		cd "${WORKDIR}/${dir}"
		emake DESTDIR="${D}" install || die
	done
}
