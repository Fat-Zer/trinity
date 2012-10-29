# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta

DESCRIPTION="tdeinit, starttde script, which starts a complete Trinity session, and associated scripts"
KEYWORDS=""
IUSE=""

RDEPEND="x11-apps/xmessage
	x11-apps/xsetroot
	x11-apps/xset
	x11-apps/xrandr
	x11-apps/mkfontdir
	x11-apps/xprop
	>=trinity-base/kdesktop-${PV}:${SLOT}
	>=trinity-base/kcminit-${PV}:${SLOT}
	>=trinity-base/ksmserver-${PV}:${SLOT}
	>=trinity-base/twin-${PV}:${SLOT}
	>=trinity-base/kpersonalizer-${PV}:${SLOT}
	>=trinity-base/kreadconfig-${PV}:${SLOT}
	>=trinity-base/ksplashml-${PV}:${SLOT}"

src_prepare() {
#	epatch "${FILESDIR}/tdebase-starttde-trinity-gentoo.patch"

	trinity-meta_src_prepare
}

src_compile() {
	trinity-meta_src_compile

	# Patch the starttde script to setup the environment for KDE 4.0
	# Add our TDEDIR
	sed -i -e "s#@REPLACE_PREFIX@#${TDEDIR}#" \
		"${S}/starttde" || die "Sed for PREFIX failed."

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Complete LDPATH
	sed -i -e "s#@REPLACE_LIBS@#${_libdirs}#" \
		"${S}/starttde" || die "Sed for LDPATH failed."
}

src_install() {
	trinity-meta_src_install
	# starttde script
	exeinto "${TDEDIR}/bin"
	doexe starttde
	doexe r14-xdg-update
	doexe migratekde3

	# startup and shutdown scripts
	exeinto "${TDEDIR}/env"
	doexe "${FILESDIR}/agent-startup.sh"

	exeinto "${TDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# freedesktop environment variables
	cat <<EOF > "${T}/xdg.sh"
export XDG_CONFIG_DIRS="${TDEDIR}/etc/xdg"
EOF
	exeinto "${TDEDIR}/env"
	doexe "${T}/xdg.sh"

	# x11 session script
	cat <<EOF > "${T}/tde-${SLOT}"
#!/bin/sh
exec ${TDEDIR}/bin/starttde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/tde-${SLOT}" # FIXME: change script branding to trinity

	# (not really) freedesktop compliant session script
	sed -e "s:@TDE_BINDIR@:${TDEDIR}/bin:g;s:Name=Trinity:Name=Trinity ${SLOT}:" \
		"${S}/tdm/kfrontend/sessions/tde.desktop.in" > "${T}/tde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/tde-${SLOT}.desktop"
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in Trinity sessions,"
	elog "edit ${TDEDIR}/env/agent-startup.sh and"
	elog "${TDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
