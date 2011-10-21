# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: support planty of ebuilds for kde-trinity project.
#

inherit cmake-utils trinity-functions


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
		 if [[ -n "$EGIT_MIRROR" ]]; then
			EGIT_MIRROR="http://scm.trinitydesktop.org/scm/git/tde"
		 	die "Trinity git repository is not work now"
		 fi
		 EGIT_REPO_URI="${EGIT_MIRROR}/${KMNAME}"
		 EGIT_BRANCH="master"
		 EGIT_PROJECT="trinity"
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
		-DCMAKE_INSTALL_RPATH="${KDEDIR}"
		-DHTML_INSTALL_DIR="${KDEDIR}/share/doc/HTML"
		"${mycmakeargs[@]}"
	)

	cmake-utils_src_configure
}

EXPORT_FUNCTIONS src_configure



