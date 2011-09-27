# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-functions.eclass,v 1.175 2009/11/01 20:26:34 abcd Exp $

# @ECLASS: kde-functions.eclass
# @MAINTAINER:
# kde@gentoo.org
# Original author Dan Armak <danarmak@gentoo.org>
#
# @BLURB: This contains everything except things that modify ebuild variables and
# @DESCRIPTION:
# This contains everything except things that modify ebuild variables
# and functions (e.g. $P, src_compile() etc.)

inherit qt3 eutils

# map of the monolithic->split ebuild derivation; used to build deps describing
# the relationships between them
KDE_DERIVATION_MAP='
kde-base/kdeaccessibility kde-base/kbstateapplet
kde-base/kdeaccessibility kde-base/kdeaccessibility-iconthemes
kde-base/kdeaccessibility kde-base/kmag
kde-base/kdeaccessibility kde-base/kmousetool
kde-base/kdeaccessibility kde-base/kmouth
kde-base/kdeaccessibility kde-base/kttsd
kde-base/kdeaccessibility kde-base/ksayit
kde-base/kdeaddons kde-base/atlantikdesigner
kde-base/kdeaddons kde-base/kaddressbook-plugins
kde-base/kdeaddons kde-base/kate-plugins
kde-base/kdeaddons kde-base/kdeaddons-docs-konq-plugins
kde-base/kdeaddons kde-base/kdeaddons-kfile-plugins
kde-base/kdeaddons kde-base/kicker-applets
kde-base/kdeaddons kde-base/knewsticker-scripts
kde-base/kdeaddons kde-base/konq-plugins
kde-base/kdeaddons kde-base/konqueror-akregator
kde-base/kdeaddons kde-base/ksig
kde-base/kdeaddons kde-base/noatun-plugins
kde-base/kdeaddons kde-base/renamedlg-audio
kde-base/kdeaddons kde-base/renamedlg-images
kde-base/kdeadmin kde-base/kcron
kde-base/kdeadmin kde-base/kdat
kde-base/kdeadmin kde-base/kdeadmin-kfile-plugins
kde-base/kdeadmin kde-base/knetworkconf
kde-base/kdeadmin kde-base/kpackage
kde-base/kdeadmin kde-base/ksysv
kde-base/kdeadmin kde-base/kuser
kde-base/kdeadmin kde-base/lilo-config
kde-base/kdeadmin kde-base/secpolicy
kde-base/kdeartwork kde-base/kdeartwork-emoticons
kde-base/kdeartwork kde-base/kdeartwork-icewm-themes
kde-base/kdeartwork kde-base/kdeartwork-iconthemes
kde-base/kdeartwork kde-base/kdeartwork-kscreensaver
kde-base/kdeartwork kde-base/kdeartwork-kwin-styles
kde-base/kdeartwork kde-base/kdeartwork-kworldclock
kde-base/kdeartwork kde-base/kdeartwork-kworldwatch
kde-base/kdeartwork kde-base/kdeartwork-sounds
kde-base/kdeartwork kde-base/kdeartwork-styles
kde-base/kdeartwork kde-base/kdeartwork-wallpapers
kde-base/kdebase kde-base/drkonqi
kde-base/kdebase kde-base/kappfinder
kde-base/kdebase kde-base/kate
kde-base/kdebase kde-base/kcheckpass
kde-base/kdebase kde-base/kcminit
kde-base/kdebase kde-base/kcontrol
kde-base/kdebase kde-base/kdcop
kde-base/kdebase kde-base/kdebase-data
kde-base/kdebase kde-base/kdebase-kioslaves
kde-base/kdebase kde-base/kdebase-startkde
kde-base/kdebase kde-base/kdebugdialog
kde-base/kdebase kde-base/kdepasswd
kde-base/kdebase kde-base/kdeprint
kde-base/kdebase kde-base/kdesktop
kde-base/kdebase kde-base/kdesu
kde-base/kdebase kde-base/kdialog
kde-base/kdebase kde-base/kdm
kde-base/kdebase kde-base/kfind
kde-base/kdebase kde-base/khelpcenter
kde-base/kdebase kde-base/khotkeys
kde-base/kdebase kde-base/kicker
kde-base/kdebase kde-base/klipper
kde-base/kdebase kde-base/kmenuedit
kde-base/kdebase kde-base/knetattach
kde-base/kdebase kde-base/konqueror
kde-base/kdebase kde-base/konsole
kde-base/kdebase kde-base/kpager
kde-base/kdebase kde-base/kpersonalizer
kde-base/kdebase kde-base/kreadconfig
kde-base/kdebase kde-base/kscreensaver
kde-base/kdebase kde-base/ksmserver
kde-base/kdebase kde-base/ksplashml
kde-base/kdebase kde-base/kstart
kde-base/kdebase kde-base/ksysguard
kde-base/kdebase kde-base/ksystraycmd
kde-base/kdebase kde-base/ktip
kde-base/kdebase kde-base/kwin
kde-base/kdebase kde-base/kxkb
kde-base/kdebase kde-base/libkonq
kde-base/kdebase kde-base/nsplugins
kde-base/kdebindings kde-base/dcopc
kde-base/kdebindings kde-base/dcopjava
kde-base/kdebindings kde-base/dcopperl
kde-base/kdebindings kde-base/dcoppython
kde-base/kdebindings kde-base/kalyptus
kde-base/kdebindings kde-base/kdejava
kde-base/kdebindings kde-base/kjsembed
kde-base/kdebindings kde-base/korundum
kde-base/kdebindings kde-base/pykde
kde-base/kdebindings kde-base/qtjava
kde-base/kdebindings kde-base/qtruby
kde-base/kdebindings kde-base/qtsharp
kde-base/kdebindings kde-base/smoke
kde-base/kdebindings kde-base/xparts
kde-base/kdeedu kde-base/blinken
kde-base/kdeedu kde-base/kalzium
kde-base/kdeedu kde-base/kanagram
kde-base/kdeedu kde-base/kbruch
kde-base/kdeedu kde-base/kdeedu-applnk
kde-base/kdeedu kde-base/keduca
kde-base/kdeedu kde-base/kgeography
kde-base/kdeedu kde-base/khangman
kde-base/kdeedu kde-base/kig
kde-base/kdeedu kde-base/kiten
kde-base/kdeedu kde-base/klatin
kde-base/kdeedu kde-base/klettres
kde-base/kdeedu kde-base/kmathtool
kde-base/kdeedu kde-base/kmessedwords
kde-base/kdeedu kde-base/kmplot
kde-base/kdeedu kde-base/kpercentage
kde-base/kdeedu kde-base/kstars
kde-base/kdeedu kde-base/ktouch
kde-base/kdeedu kde-base/kturtle
kde-base/kdeedu kde-base/kverbos
kde-base/kdeedu kde-base/kvoctrain
kde-base/kdeedu kde-base/kwordquiz
kde-base/kdeedu kde-base/libkdeedu
kde-base/kdegames kde-base/atlantik
kde-base/kdegames kde-base/kasteroids
kde-base/kdegames kde-base/katomic
kde-base/kdegames kde-base/kbackgammon
kde-base/kdegames kde-base/kbattleship
kde-base/kdegames kde-base/kblackbox
kde-base/kdegames kde-base/kbounce
kde-base/kdegames kde-base/kenolaba
kde-base/kdegames kde-base/kfouleggs
kde-base/kdegames kde-base/kgoldrunner
kde-base/kdegames kde-base/kjumpingcube
kde-base/kdegames kde-base/klickety
kde-base/kdegames kde-base/klines
kde-base/kdegames kde-base/kmahjongg
kde-base/kdegames kde-base/kmines
kde-base/kdegames kde-base/knetwalk
kde-base/kdegames kde-base/kolf
kde-base/kdegames kde-base/konquest
kde-base/kdegames kde-base/kpat
kde-base/kdegames kde-base/kpoker
kde-base/kdegames kde-base/kreversi
kde-base/kdegames kde-base/ksame
kde-base/kdegames kde-base/kshisen
kde-base/kdegames kde-base/ksirtet
kde-base/kdegames kde-base/ksmiletris
kde-base/kdegames kde-base/ksnake
kde-base/kdegames kde-base/ksokoban
kde-base/kdegames kde-base/kspaceduel
kde-base/kdegames kde-base/ktron
kde-base/kdegames kde-base/ktuberling
kde-base/kdegames kde-base/kwin4
kde-base/kdegames kde-base/libkdegames
kde-base/kdegames kde-base/libksirtet
kde-base/kdegames kde-base/lskat
kde-base/kdegraphics kde-base/kamera
kde-base/kdegraphics kde-base/kcoloredit
kde-base/kdegraphics kde-base/kdegraphics-kfile-plugins
kde-base/kdegraphics kde-base/kdvi
kde-base/kdegraphics kde-base/kfax
kde-base/kdegraphics kde-base/kgamma
kde-base/kdegraphics kde-base/kghostview
kde-base/kdegraphics kde-base/kiconedit
kde-base/kdegraphics kde-base/kmrml
kde-base/kdegraphics kde-base/kolourpaint
kde-base/kdegraphics kde-base/kooka
kde-base/kdegraphics kde-base/kpdf
kde-base/kdegraphics kde-base/kpovmodeler
kde-base/kdegraphics kde-base/kruler
kde-base/kdegraphics kde-base/ksnapshot
kde-base/kdegraphics kde-base/ksvg
kde-base/kdegraphics kde-base/kuickshow
kde-base/kdegraphics kde-base/kview
kde-base/kdegraphics kde-base/kviewshell
kde-base/kdegraphics kde-base/libkscan
kde-base/kdemultimedia kde-base/akode
kde-base/kdemultimedia kde-base/artsplugin-akode
kde-base/kdemultimedia kde-base/artsplugin-audiofile
kde-base/kdemultimedia kde-base/artsplugin-mpeglib
kde-base/kdemultimedia kde-base/artsplugin-mpg123
kde-base/kdemultimedia kde-base/artsplugin-xine
kde-base/kdemultimedia kde-base/juk
kde-base/kdemultimedia kde-base/kaboodle
kde-base/kdemultimedia kde-base/kaudiocreator
kde-base/kdemultimedia kde-base/kdemultimedia-arts
kde-base/kdemultimedia kde-base/kdemultimedia-kappfinder-data
kde-base/kdemultimedia kde-base/kdemultimedia-kfile-plugins
kde-base/kdemultimedia kde-base/kdemultimedia-kioslaves
kde-base/kdemultimedia kde-base/kmid
kde-base/kdemultimedia kde-base/kmix
kde-base/kdemultimedia kde-base/krec
kde-base/kdemultimedia kde-base/kscd
kde-base/kdemultimedia kde-base/libkcddb
kde-base/kdemultimedia kde-base/mpeglib
kde-base/kdemultimedia kde-base/noatun
kde-base/kdenetwork kde-base/dcoprss
kde-base/kdenetwork kde-base/kdenetwork-filesharing
kde-base/kdenetwork kde-base/kdenetwork-kfile-plugins
kde-base/kdenetwork kde-base/kdict
kde-base/kdenetwork kde-base/kdnssd
kde-base/kdenetwork kde-base/kget
kde-base/kdenetwork kde-base/knewsticker
kde-base/kdenetwork kde-base/kopete
kde-base/kdenetwork kde-base/kpf
kde-base/kdenetwork kde-base/kppp
kde-base/kdenetwork kde-base/krdc
kde-base/kdenetwork kde-base/krfb
kde-base/kdenetwork kde-base/ksirc
kde-base/kdenetwork kde-base/ktalkd
kde-base/kdenetwork kde-base/kwifimanager
kde-base/kdenetwork kde-base/librss
kde-base/kdenetwork kde-base/lisa
kde-base/kdepim kde-base/akregator
kde-base/kdepim kde-base/certmanager
kde-base/kdepim kde-base/kaddressbook
kde-base/kdepim kde-base/kalarm
kde-base/kdepim kde-base/kandy
kde-base/kdepim kde-base/karm
kde-base/kdepim kde-base/kdepim-kioslaves
kde-base/kdepim kde-base/kdepim-kresources
kde-base/kdepim kde-base/kdepim-wizards
kde-base/kdepim kde-base/kitchensync
kde-base/kdepim kde-base/kmail
kde-base/kdepim kde-base/kmailcvt
kde-base/kdepim kde-base/knode
kde-base/kdepim kde-base/knotes
kde-base/kdepim kde-base/kode
kde-base/kdepim kde-base/konsolekalendar
kde-base/kdepim kde-base/kontact
kde-base/kdepim kde-base/kontact-specialdates
kde-base/kdepim kde-base/korganizer
kde-base/kdepim kde-base/korn
kde-base/kdepim kde-base/kpilot
kde-base/kdepim kde-base/ksync
kde-base/kdepim kde-base/ktnef
kde-base/kdepim kde-base/libkcal
kde-base/kdepim kde-base/libkdenetwork
kde-base/kdepim kde-base/libkdepim
kde-base/kdepim kde-base/libkholidays
kde-base/kdepim kde-base/libkmime
kde-base/kdepim kde-base/libkpgp
kde-base/kdepim kde-base/libkpimexchange
kde-base/kdepim kde-base/libkpimidentities
kde-base/kdepim kde-base/libksieve
kde-base/kdepim kde-base/mimelib
kde-base/kdepim kde-base/networkstatus
kde-base/kdesdk kde-base/cervisia
kde-base/kdesdk kde-base/kapptemplate
kde-base/kdesdk kde-base/kbabel
kde-base/kdesdk kde-base/kbugbuster
kde-base/kdesdk kde-base/kcachegrind
kde-base/kdesdk kde-base/kdesdk-kfile-plugins
kde-base/kdesdk kde-base/kdesdk-kioslaves
kde-base/kdesdk kde-base/kdesdk-misc
kde-base/kdesdk kde-base/kdesdk-scripts
kde-base/kdesdk kde-base/kmtrace
kde-base/kdesdk kde-base/kompare
kde-base/kdesdk kde-base/kspy
kde-base/kdesdk kde-base/kuiviewer
kde-base/kdesdk kde-base/umbrello
kde-base/kdetoys kde-base/amor
kde-base/kdetoys kde-base/eyesapplet
kde-base/kdetoys kde-base/fifteenapplet
kde-base/kdetoys kde-base/kmoon
kde-base/kdetoys kde-base/kodo
kde-base/kdetoys kde-base/kteatime
kde-base/kdetoys kde-base/ktux
kde-base/kdetoys kde-base/kweather
kde-base/kdetoys kde-base/kworldclock
kde-base/kdetoys kde-base/kworldwatch
kde-base/kdeutils kde-base/ark
kde-base/kdeutils kde-base/kcalc
kde-base/kdeutils kde-base/kcharselect
kde-base/kdeutils kde-base/kdelirc
kde-base/kdeutils kde-base/kdf
kde-base/kdeutils kde-base/kedit
kde-base/kdeutils kde-base/kfloppy
kde-base/kdeutils kde-base/kgpg
kde-base/kdeutils kde-base/khexedit
kde-base/kdeutils kde-base/kjots
kde-base/kdeutils kde-base/klaptopdaemon
kde-base/kdeutils kde-base/kmilo
kde-base/kdeutils kde-base/kregexpeditor
kde-base/kdeutils kde-base/ksim
kde-base/kdeutils kde-base/ktimer
kde-base/kdeutils kde-base/kwalletmanager
kde-base/kdeutils kde-base/superkaramba
kde-base/kdewebdev kde-base/kfilereplace
kde-base/kdewebdev kde-base/kimagemapeditor
kde-base/kdewebdev kde-base/klinkstatus
kde-base/kdewebdev kde-base/kommander
kde-base/kdewebdev kde-base/kxsldbg
kde-base/kdewebdev kde-base/quanta
app-office/koffice app-office/karbon
app-office/koffice app-office/kchart
app-office/koffice app-office/kexi
app-office/koffice app-office/kformula
app-office/koffice app-office/kivio
app-office/koffice app-office/koffice-data
app-office/koffice app-office/koffice-libs
app-office/koffice app-office/koffice-meta
app-office/koffice app-office/koshell
app-office/koffice app-office/kplato
app-office/koffice app-office/kpresenter
app-office/koffice app-office/krita
app-office/koffice app-office/kspread
app-office/koffice app-office/kugar
app-office/koffice app-office/kword
'

# @FUNCTION: get-parent-package
# @USAGE: < name of split-ebuild >
# @DESCRIPTION:
# accepts 1 parameter, the name of a split ebuild; echoes the name of its mother package
get-parent-package() {
	local parent child
	while read parent child; do
		if [[ ${child} == $1 ]]; then
			echo ${parent}
			return 0
		fi
	done <<EOF
$KDE_DERIVATION_MAP
EOF
	die "Package $1 not found in KDE_DERIVATION_MAP, please report bug"
}

# @FUNCTION: get-child-packages
# @USAGE: < name of monolithic package >
# @DESCRIPTION:
# accepts 1 parameter, the name of a monolithic package; echoes the names of all ebuilds derived from it
get-child-packages() {
	local parent child
	while read parent child; do
		[[ ${parent} == $1 ]] && echo -n "${child} "
	done <<EOF
$KDE_DERIVATION_MAP
EOF
}

# @FUNCTION: is-parent-package
# @USAGE: < name >
# @RETURN: 0 if <name> is a parent package, otherwise 1
is-parent-package() {
	local parent child
	while read parent child; do
		[[ "${parent}" == "$1" ]] && return 0
	done <<EOF
$KDE_DERIVATION_MAP
EOF
	return 1
}

# ---------------------------------------------------------------
# kde/qt directory management etc. functions, was kde-dirs.ebuild
# ---------------------------------------------------------------

# @FUNCTION: need-kde
# @USAGE: < version >
# @DESCRIPTION:
# Sets the correct DEPEND and RDEPEND for the needed kde < version >. Also takes
# care of the correct Qt-version and correct RDEPEND handling.
need-kde() {
	debug-print-function $FUNCNAME "$@"

	KDEVER="$1"

	# determine install locations
	set-kdedir ${KDEVER}

	if [[ "${RDEPEND-unset}" != "unset" ]]; then
		x_DEPEND="${RDEPEND}"
	else
		x_DEPEND="${DEPEND}"
	fi
	if [[ -n "${KDEBASE}" ]]; then
		# If we're a kde-base package, we need at least our own version of kdelibs.
		# Note: we only set RDEPEND if it is already set, otherwise
		# we break packages relying on portage copying RDEPEND from DEPEND.
		DEPEND="${DEPEND} ~kde-base/kdelibs-$PV"
		RDEPEND="${x_DEPEND} ~kde-base/kdelibs-${PV}"
	else
		# Things outside kde-base need a minimum version,
		# but kde-base/kdelibs:kde-4 mustn't satisfy it.
		min-kde-ver ${KDEVER}
		DEPEND="${DEPEND} =kde-base/kdelibs-3.5*"
		RDEPEND="${x_DEPEND} =kde-base/kdelibs-3.5*"
	fi

	qtver-from-kdever ${KDEVER}
	need-qt ${selected_version}

	if [[ -n "${KDEBASE}" ]]; then
		SLOT="$KDEMAJORVER.$KDEMINORVER"
	else
		: ${SLOT="0"}
	fi
}

# @FUNCTION: set-kdedir
# @USAGE: < version >
# @DESCRIPTION:
# Sets the right directories for the kde <version> wrt what kind of package will
# be installed, e. g. third-party-apps, kde-base-packages, ...
set-kdedir() {
	debug-print-function $FUNCNAME "$@"


	# set install location:
	# - 3rd party apps go into /usr, and have SLOT="0".
	# - kde-base category ebuilds go into /usr/kde/$MAJORVER.$MINORVER,
	# and have SLOT="$MAJORVER.$MINORVER".
	# - kde-base category cvs ebuilds have major version 5 and go into
	# /usr/kde/cvs; they have SLOT="cvs".
	# - Backward-compatibility exceptions: all kde2 packages (kde-base or otherwise)
	# go into /usr/kde/2. kde 3.0.x goes into /usr/kde/3 (and not 3.0).
	# - kde-base category ebuilds always depend on their exact matching version of
	# kdelibs and link against it. Other ebuilds link aginst the latest one found.
	# - This function exports $PREFIX (location to install to) and $KDEDIR
	# (location of kdelibs to link against) for all ebuilds.
	#
	# -- Overrides - deprecated but working for now: --
	# - If $KDEPREFIX is defined (in the profile or env), it overrides everything
	# and both base and 3rd party kde stuff goes in there.
	# - If $KDELIBSDIR is defined, the kdelibs installed in that location will be
	# used, even by kde-base packages.

	# get version elements
	IFSBACKUP="$IFS"
	IFS=".-_"
	for x in $1; do
		if [[ -z "$KDEMAJORVER" ]]; then KDEMAJORVER=$x
		else if [[ -z "$KDEMINORVER" ]]; then KDEMINORVER=$x
		else if [[ -z "$KDEREVISION" ]]; then KDEREVISION=$x
		fi; fi; fi
	done
	[[ -z "$KDEMINORVER" ]] && KDEMINORVER="0"
	[[ -z "$KDEREVISION" ]] && KDEREVISION="0"
	IFS="$IFSBACKUP"
	debug-print "$FUNCNAME: version breakup: KDEMAJORVER=$KDEMAJORVER KDEMINORVER=$KDEMINORVER KDEREVISION=$KDEREVISION"

	# install prefix
	if [[ -n "$KDEPREFIX" ]]; then
		export PREFIX="$KDEPREFIX"
	else
		if  [[ -z "$KDEBASE" ]]; then
			PREFIX="/usr/kde/3.5"
		else
			case $KDEMAJORVER.$KDEMINORVER in
				3*) export PREFIX="/usr/kde/3.5";;
				5.0) export PREFIX="/usr/kde/svn";;
				*) die "failed to set PREFIX";;
			esac
		fi
	fi

	# kdelibs location
	if [[ -n "$KDELIBSDIR" ]]; then
		export KDEDIR="$KDELIBSDIR"
	else
		if [[ -z "$KDEBASE" ]]; then
			# find the latest kdelibs installed
			for x in /usr/kde/{svn,3.5} "${PREFIX}" \
				"${KDE3LIBSDIR}" "${KDELIBSDIR}" "${KDE3DIR}" "${KDEDIR}" /usr/kde/*; do
				if [[ -f "${x}/include/kwin.h" ]]; then
					debug-print found
					export KDEDIR="$x"
					break
				fi
			done
		else
			# kde-base ebuilds must always use the exact version of kdelibs they came with
			case $KDEMAJORVER.$KDEMINORVER in
				3*) export KDEDIR="/usr/kde/3.5";;
				5.0) export KDEDIR="/usr/kde/svn";;
				*) die "failed to set KDEDIR";;
			esac
		fi
	fi

	debug-print "$FUNCNAME: Will use the kdelibs installed in $KDEDIR, and install into $PREFIX."
}

# @FUNCTION: need-qt
# @USAGE: < version >
# @DESCRIPTION:
# Sets the DEPEND and RDEPEND for Qt <version>.
need-qt() {
	debug-print-function $FUNCNAME "${@}"

	QTVER="$1"

	QT=qt

	if [[ "${RDEPEND-unset}" != "unset" ]]; then
		x_DEPEND="${RDEPEND}"
	else
		x_DEPEND="${DEPEND}"
	fi

	case ${QTVER} in
		3*)	DEPEND="${DEPEND} =x11-libs/qt-meta-3*"
			RDEPEND="${RDEPEND} =x11-libs/qt-meta-3*"
			;;
		*)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$QTVER\", please report bug" && exit 1;;
	esac

}

# @FUNCTION: set-qtdir
# @DESCRIPTION:
# This function is not needed anymore.
set-qtdir() {
	:
}

# @FUNCTION: qtver-from-kdever
# @USAGE: < kde-version >
# @DESCRIPTION:
# returns minimal qt version needed for specified kde version
qtver-from-kdever() {
	debug-print-function $FUNCNAME "$@"

	local ver

	case $1 in
		3.1*)	ver=3.1;;
		3.2*)	ver=3.2;;
		3.3*)	ver=3.3;;
		3.4*)	ver=3.3;;
		3.5*)	ver=3.3;;
		3*)	ver=3.0.5;;
		5)	ver=3.3;; # cvs version
		*)	echo "!!! error: $FUNCNAME called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}

min-kde-ver() {
	debug-print-function $FUNCNAME "$@"

	case $1 in
		3.0*)			selected_version="3.0";;
		3.1*)			selected_version="3.1";;
		3.2*)			selected_version="3.2";;
		3.3*)			selected_version="3.3";;
		3.4*)			selected_version="3.4";;
		3.5*)			selected_version="3.5";;
		3*)			selected_version="3.0";;
		5)			selected_version="5";;
		*)			echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

}

# @FUNCTION: kde_sandbox_patch
# @USAGE: < dir > [ dir ] [ dir ] [...]
# @DESCRIPTION:
# generic makefile sed for sandbox compatibility. for some reason when the kde makefiles (of many packages
# and versions) try to chown root and chmod 4755 some binaries (after installing, target install-exec-local),
# they do it to the files in $(bindir), not $(DESTDIR)/$(bindir). Most of these have been fixed in latest cvs
# but a few remain here and there.
#
# Pass a list of dirs to sed, Makefile.{am,in} in these dirs will be sed'ed.
# This should be harmless if the makefile doesn't need fixing.
kde_sandbox_patch() {
	debug-print-function $FUNCNAME "$@"

	while [[ -n "$1" ]]; do
	# can't use dosed, because it only works for things in ${D}, not ${S}
	cd $1
	for x in Makefile.am Makefile.in Makefile
	do
		if [[ -f "$x" ]]; then
			echo Running sed on $x
			cp $x ${x}.orig
			sed -e 's: $(bindir): $(DESTDIR)/$(bindir):g' -e 's: $(kde_datadir): $(DESTDIR)/$(kde_datadir):g' -e 's: $(TIMID_DIR): $(DESTDIR)/$(TIMID_DIR):g' ${x}.orig > ${x}
			rm ${x}.orig
		fi
	done
	shift
	done

}

# @FUNCTION: kde_remove_flag
# @USAGE: < dir > < flag >
# @DESCRIPTION:
# remove an optimization flag from a specific subdirectory's makefiles.
# currently kdebase and koffice use it to compile certain subdirs without
# -fomit-frame-pointer which breaks some things.
kde_remove_flag() {
	debug-print-function $FUNCNAME "$@"

	cd "${S}"/${1} || die "cd to '${S}/${1}' failed."
	[[ -n "$2" ]] || die "missing argument to kde_remove_flag"

	cp Makefile Makefile.orig
	sed -e "/CFLAGS/ s/${2}//g
/CXXFLAGS/ s/${2}//g" Makefile.orig > Makefile

	cd "${OLDPWD}"

}

buildsycoca() {
	[[ $EBUILD_PHASE != postinst ]] && [[ $EBUILD_PHASE != postrm ]] && \
		die "buildsycoca() has to be calles in pkg_postinst() and pkg_postrm()."

	if [[ -x ${KDEDIR}/bin/kbuildsycoca ]] && [[ -z ${ROOT} || ${ROOT} == "/" ]] ; then
		# First of all, make sure that the /usr/share/services directory exists
		# and it has the right permissions
		mkdir -p /usr/share/services
		chown root:0 /usr/share/services
		chmod 0755 /usr/share/services

		ebegin "Running kbuildsycoca to build global database"
		# Filter all KDEDIRs not belonging to the current SLOT from XDG_DATA_DIRS
		# before running kbuildsycoca. This makes sure they don't show up in the
		# 3.5 K-menu unless the user manually adds them.
		XDG_DATA_DIRS="/usr/share:${KDEDIR}/share:/usr/local/share"
		"${KDEDIR}"/bin/kbuildsycoca --global --noincremental &> /dev/null
		eend $?
	fi
}

postprocess_desktop_entries() {
	[[ $EBUILD_PHASE != preinst ]] && [[ $EBUILD_PHASE != install ]] && \
		die "postprocess_desktop_entries() has to be called in src_install() or pkg_preinst()."

	if [[ -d ${D}${PREFIX}/share/applnk ]] ; then
		# min/max depth is _important_ as it excludes legacy KDE stuff. Moving it would cause breakage.
		local desktop_entries="$(find "${D}${PREFIX}/share/applnk" -mindepth 2 -maxdepth 2 \
									-name '*\.desktop' -not -path '*.hidden*' 2>/dev/null)"

		if [[ -n ${desktop_entries} ]]; then
			for entry in ${desktop_entries} ; do
				if ! [[ -f "${D}${PREFIX}"/share/applications/kde/${entry##*/} ]] ; then
					dodir "${PREFIX}"/share/applications/kde
					mv ${entry} "${D}${PREFIX}"/share/applications/kde
				fi
			done
		fi
	fi

	validate_desktop_entries "${PREFIX}"/share/applications
}

# is this a kde-base ebuid?
if [[ "${CATEGORY}" == "kde-base" ]]; then
	debug-print "${ECLASS}: KDEBASE ebuild recognized"
	export KDEBASE="true"
	export KDEREVISION
fi
