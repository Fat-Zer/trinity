# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="qt4-tqt-theme-engine"

inherit trinity-base qt4-r2

DESCRIPTION="A trinity Qt4 theme engine using tqt as a backend"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-qt/tqtinterface
	>=dev-qt/qtcore-4.8.4:4
	>=dev-qt/qtgui-4.8.4:4"
RDEPEND="$DEPEND"

need-trinity 9999

src_unpack() {
	trinity-base_src_unpack
}

src_prepare() {
	local pro  libdirs d

	trinity-base_src_prepare

	for d in $(get-trinity-libdirs); do
		libdirs+=" -L$d"
	done

	for d in $(get_all_libdirs); do
		libdirs+=" -L/usr/tqt3/$d"
	done

	for pro in ./plugin/plugin.pro ./lib/lib.pro ./examples/tqt3reference/stylewindow.pro; do
		sed -i -e 's!\(^INCLUDEPATH += \)/usr/include/tqt3!\1/usr/tqt3/include!;' \
			-e 's!\(^INCLUDEPATH += \)/opt/trinity/include!\1'"$TDEDIR/include"'!;' \
			-e '/\(^LIBS += \)/s!!\1 '"$libdirs"'!' $pro || die "sed failed"
	done
	epatch "${FILESDIR}/qt4-tqt-theme-engine-suppress-annoying-warning-about-qt-version.pacth"
}

src_configure() {
	qt4-r2_src_configure
}

src_compile() {
	qt4-r2_src_compile
}

src_install() {
	qt4-r2_src_install
}

pkg_postinst() {
	ewarn "With Qt >= 4.8.0 you are likely affected by these Qt4 bug:"
	ewarn "   https://bugreports.qt.io/browse/QTBUG-25896"
	ewarn "To workaround this please make sure to set your Qt graphics system to \"native\""
	ewarn "rather than \"opengl\". Otherwice Qt4 applications may be displayed with numerous"
	ewarn "graphical glitches."
}
