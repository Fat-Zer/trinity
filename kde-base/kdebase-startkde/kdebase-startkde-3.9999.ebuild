# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-base multilib
set-kdever 3.5

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
SLOT="${TRINITY_LIVEVER}"
KEYWORDS=""
IUSE=""

RDEPEND="x11-apps/xmessage
	x11-apps/xsetroot
	x11-apps/xset
	x11-apps/xrandr
	x11-apps/mkfontdir
	x11-apps/xprop
	>=kde-base/kdesktop-${PV}:${SLOT}
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/ksmserver-${PV}:${SLOT}
	>=kde-base/kwin-${PV}:${SLOT}
	>=kde-base/kpersonalizer-${PV}:${SLOT}
	>=kde-base/kreadconfig-${PV}:${SLOT}
	>=kde-base/ksplashml-${PV}:${SLOT}"

src_prepare() {
	epatch "${FILESDIR}/kdebase-startkde-trinity-gentoo.patch"
}

src_configure() {
	echo -n "";
}

src_compile() {
	# Patch the startkde script to setup the environment for KDE 4.0
	# Add our KDEDIR
	sed -i -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
		"${S}/startkde" || die "Sed for PREFIX failed."

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Complete LDPATH
	sed -i -e "s#@REPLACE_LIBS@#${_libdirs}#" \
		"${S}/startkde" || die "Sed for LDPATH failed."
}

src_install() {
	# startkde script
	exeinto "${KDEDIR}/bin"
	doexe startkde

	# startup and shutdown scripts
	exeinto "${KDEDIR}/env"
	doexe "${FILESDIR}/agent-startup.sh"

	exeinto "${KDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# freedesktop environment variables
	cat <<EOF > "${T}/xdg.sh"
export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
EOF
	exeinto "${KDEDIR}/env"
	doexe "${T}/xdg.sh"

	# x11 session script
	cat <<EOF > "${T}/tde-${SLOT}"
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/tde-${SLOT}" # FIXME: change script branding to trinity

	# (not really) freedesktop compliant session script
	sed -e "s:@TDE_BINDIR@:${KDEDIR}/bin:g;s:Name=TDE:Name=TDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/tde.desktop.in" > "${T}/tde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/tde-${SLOT}.desktop"
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
