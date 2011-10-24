# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: support planty of ebuilds for kde-trinity project.
#

inherit cmake-utils trinity-functions

# @ECLASS-VARIABLE: BUILD_TYPE
# @DESCRIPTION:
# Determins he build type: live or release

# @ECLASS-VARIABLE: KDE_SCM
# @DESCRIPTION:
# Determins from what version control system code is chiking out for live
# ebuilds.

# @ECLASS-VARIABLE: KCOMMON_DOCS
# @DESCRIPTION:
# Common doc names that was found in trinity project's dirs.
KCOMMON_DOCS="AUTHORS BUGS CHANGELOG CHANGES COMMENTS COMPLIANCE COMPILING
	CONFIG_FORMAT CONFIGURING COPYING COPYRIGHT CREDITS DEBUG DESIGN FAQ 
	HACKING HISTORY HOWTO IDEAS INSTALL LICENSE MAINTAINERS NAMING NEWS
	NOTES PLUGINS PORTING README SECURITY-HOLES TASKGROUPS TEMPLATE 
	TESTCASES THANKS THOUGHTS TODO VERSION"



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
		*) die "Unsupported KDE_SCM=$KDE_SCM" ;;
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
		 EGIT_PROJECT="trinity/$(dirname $KMNAME)"
	;;
	svn) ESVN_MIRROR="svn://anonsvn.kde.org/home/kde/branches/trinity"
		 ESVN_REPO_URI="${ESVN_MIRROR}/${KMNAME}"
		 ESVN_PROJECT="trinity/$(dirname $KMNAME)"
	;;
	esac
fi

# if [[ ${CATEGORY} == "kde-base" ]]; then
# 	# Get the aRts dependencies right - finally.
# 	case "${PN}" in
# 		blinken|juk|kalarm|kanagram|kbounce|kcontrol|konq-plugins|kscd|kscreensaver|kttsd|kwifimanager|kdelibs) ARTS_REQUIRED="" ;;
# 		artsplugin-*|kaboodle|kasteroids|kdemultimedia-arts|kolf|krec|ksayit|noatun*) ARTS_REQUIRED="yes" ;;
# 		*) ARTS_REQUIRED="never" ;;
# 	esac
# fi

# @FUNCTION: trinity-base_src_configure
# @DESCRIPTION:
# Call standart cmake-utils_src_onfigure and add some common arguments.
trinity-base_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	mycmakeargs=(
		-DCMAKE_INSTALL_RPATH="${KDEDIR}"
		-DHTML_INSTALL_DIR="${KDEDIR}/share/doc/HTML"
		"${mycmakeargs[@]}"
	)

	cmake-utils_src_configure
}

# @FUNCTION: trinity-base_src_install
# @DESCRIPTION:
# Call standart cmake-utils_src_install and installs common documentation. 
# Also see descriptions of KCOMMON_DOCS.
trinity-base_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	cmake-utils_src_install

	local doc docfile targetdoc;

	mkdir -p "$T/docs"

	for doc in ${KCOMMON_DOCS}; do
		for docfile in $(find -type f -name "*${doc}*"); do
			targetdoc="${docfile//\//.}"
			targetdoc="${targetdoc#..}"
			cp "${docfile}" "$T/docs/${targetdoc}"
			dodoc "$T/docs/${targetdoc}"
			einfo "Installing documentation ${targetdoc}"
			rm "$T/docs/$targetdoc"
		done
	done
}

EXPORT_FUNCTIONS src_configure src_install



