# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: support planty of ebuilds for kde-trinity project.
#

inherit cmake-utils versionator

TRINITY_LIVEVER="3.5"

# @FUNCTION: set-kdever
# @USAGE: < version >
# @DESCRIPTION:
# Sets the right directories for the kde <version> wrt what kind of package will
# be installed, e. g. third-party-apps, kde-base-packages, ...
# !!! unfinished
set-kdever() {
	debug-print-function $FUNCNAME "$@"

	# set install location:
	# - 3rd party apps go into /usr, and have SLOT="0".
	# - kde-base category ebuilds go into /usr/kde/$MAJORVER.$MINORVER,
	# and have SLOT="$MAJORVER.$MINORVER".
	# - This function exports $PREFIX (location to install to) and $KDEDIR
	# (location of kdelibs to link against) for all ebuilds.
	#
	# -- Overrides - deprecated but working for now: --
	# - If $KDEPREFIX is defined (in the profile or env), it overrides everything
	# and both base and 3rd party kde stuff goes in there.
	# - If $KDELIBSDIR is defined, the kdelibs installed in that location will be
	# used, even by kde-base packages.

	# get version elements
	if [[ -n "$1" ]]; then
		KDEVER="$1"
	else
		KDEVER="$PV"
	fi

	export KDEVER=$(get_version_component_range 1-2 ${KDEVER})
	[[ "$KDEVER" = "3.9999" ]] && export KDEVER="${TRINITY_LIVEVER}"

	# install prefix
#	if [[ -n "$KDEPREFIX" ]]; then
#		export PREFIX="$KDEPREFIX"
#	else
		export PREFIX="/usr/kde/${KDEVER}"
#	fi

	# kdelibs location
#	if [[ -n "$KDELIBSDIR" ]]; then
#		export KDEDIR="$KDELIBSDIR"
#	else
		export KDEDIR="${PREFIX}"
#	fi
}

# determine the build type
if [[ ${PV} = *9999* ]]; then
	BUILD_TYPE="live"
else
	BUILD_TYPE="release"
	die "Releases is not supported yet"
fi
export BUILD_TYPE

#reset KDE_SCM and inherit proper eclass
if [[ ${BUILD_TYPE} = live ]]; then
	# set default KDE_SCM if not set
	[[ -z "$KDE_SCM" ]] && KDE_SCM=svn

	case ${KDE_SCM} in
		git) inherit git-2 ;;
		svn) inherit subversion ;;
		*) die "Unsupported $KDE_SCM" ;;
	esac

	#set some varyables
	case ${KDE_SCM} in
	git)
		 EGIT_REPO_URI="http://scm.trinitydesktop.org/scm/git/tde"
		 EGIT_BRANCH="master"
		 EGIT_PROJECT="trinity"
		 die "git doesn't work now"
	;;
	svn) ESVN_MIRROR="svn://anonsvn.kde.org/home/kde/branches/trinity"
		 ESVN_REPO_URI="${ESVN_MIRROR}/${KMNAME}"
		 ESVN_PROJECT="trinity"
	;;
	esac
fi

if [[ ${CATEGORY} == "kde-base" ]]; then
	# Get the aRts dependencies right - finally.
	case "${PN}" in
		blinken|juk|kalarm|kanagram|kbounce|kcontrol|konq-plugins|kscd|kscreensaver|kttsd|kwifimanager|kdelibs) ARTS_REQUIRED="" ;;
		artsplugin-*|kaboodle|kasteroids|kdemultimedia-arts|kolf|krec|ksayit|noatun*) ARTS_REQUIRED="yes" ;;
		*) ARTS_REQUIRED="never" ;;
	esac
fi

# if [[ ${ARTS_REQUIRED} == "yes" ]]; then
# 	DEPEND="${DEPEND} kde-base/arts"
# 	RDEPEND="${RDEPEND} kde-base/arts"
# elif [[ ${ARTS_REQUIRED} != "never" && ${PN} != "arts" ]]; then
# 	IUSE+="arts"
# 	DEPEND="${DEPEND} arts? ( kde-base/arts )"
# 	RDEPEND="${RDEPEND} arts? ( kde-base/arts )"
# fi

trinity-base_src_configure() {

	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH=${KDEDIR}
		"${mycmakeargs[@]}"
	)

	cmake-utils_src_configure
}

EXPORT_FUNCTIONS src_configure



