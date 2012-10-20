# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: support planty of ebuilds for trinity project (a kde3 fork).
#

inherit cmake-utils trinity-functions

# @ECLASS-VARIABLE: BUILD_TYPE
# @DESCRIPTION:
# Determins he build type: live or release

# @ECLASS-VARIABLE: TRINITY_SCM
# @DESCRIPTION:
# Determins from what version control system code is chiking out for live
# ebuilds.

# @ECLASS-VARIABLE: TMP_DOCDIR
# @DESCRIPTION: 
# A temporary directory used to copy common documentation before installing it
# 


# @ECLASS-VARIABLE: TRINITY_COMMON_DOCS
# @DESCRIPTION:
# Common doc names that was found in trinity project's dirs.
TRINITY_COMMON_DOCS="AUTHORS BUGS CHANGELOG CHANGES COMMENTS COMPLIANCE COMPILING
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

#reset TRINITY_SCM and inherit proper eclass
if [[ ${BUILD_TYPE} = live ]]; then
	# set default TRINITY_SCM if not set
	[[ -z "$TRINITY_SCM" ]] && TRINITY_SCM=git

	case ${TRINITY_SCM} in
		git) inherit git-2 ;;
		svn) inherit subversion ;;
		*) die "Unsupported TRINITY_SCM=${TRINITY_SCM}" ;;
	esac

	#set some varyables
	case ${TRINITY_SCM} in
	git)
		 if [[ -z "$EGIT_MIRROR" ]]; then
			EGIT_MIRROR="http://git.trinitydesktop.org/cgit"
		 fi
		 EGIT_REPO_URI="${EGIT_MIRROR}/${TRINITY_MODULE_NAME}"
		 EGIT_BRANCH="master"
		 EGIT_PROJECT="trinity/${TRINITY_MODULE_NAME}"
		 EGIT_HAS_SUBMODULES="yes"
	;;
#	svn) ESVN_MIRROR="svn://anonsvn.kde.org/home/kde/branches/trinity"
#		 ESVN_REPO_URI="${ESVN_MIRROR}/${TRINITY_MODULE_NAME}"
#		 ESVN_PROJECT="trinity/$(dirname $TRINITY_MODULE_NAME)"
#	;;
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
		-DCMAKE_INSTALL_PREFIX="${TRINITY_DIR}"
		-DCMAKE_INSTALL_RPATH="${TRINITY_DIR}"
		"${mycmakeargs[@]}"
	)

	cmake-utils_src_configure
}

# @FUNCTION: trinity-base_src_install
# @DESCRIPTION:
# Call standart cmake-utils_src_install and installs common documentation. 
trinity-base_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	cmake-utils_src_install

	trinity-base_create_tmp_docfiles
	trinity-base_install_docfiles
}

# @FUNCTION: trinity-base_create_tmp_docfiles
# @DESCRIPTION:
# Create docfiles in the form ${TMP_DOCDIR}/path.to.docfile.COMMON_NAME
# Also see the description for TRINITY_COMMON_DOCS and TMP_DOCDIR.
trinity-base_create_tmp_docfiles() {
	debug-print-function ${FUNCNAME} "$@"
	local srcdirs dir docfile targetdoc

	if [[ -z "$TMP_DOCDIR" || ! -d "$TMP_DOCDIR" ]] ; then
		TMP_DOCDIR="$T/docs"
		mkdir -p ${TMP_DOCDIR}
	fi

	if [[ -z "$@" ]] ; then
		srcdirs="./"
	else
		srcdirs="$@"
	fi

	einfo "Generating documentation list..."
	for dir in $srcdirs; do
		for doc in ${TRINITY_COMMON_DOCS}; do
			for docfile in $(find $dir -type f -name "*${doc}*"); do
				targetdoc="${docfile//\//.}"
				targetdoc="${targetdoc#..}"
				cp "${docfile}" "$TMP_DOCDIR/${targetdoc}"
			done
		done
	done

#	if [[ "${TRINITY_INSTALL_ROOT_DOCS}" == "yes" && " ${srcdirs} " == "* ./ *" ]]; then
#		for doc in ${TRINITY_COMMON_DOCS}; do
#			for docfile in $(ls ./"*${doc}*"); do
#				targetdoc="${docfile//\//.}"
#				targetdoc="${targetdoc#..}"
#				cp "${docfile}" "$TMP_DOCDIR/${targetdoc}"
#			done
#		done
#	fi
}

# @FUNCTION: trinity-base_install_docfiles
# @DESCRIPTION:
# Install documentation from ${TMP_DOCDIR} or from first argument.
trinity-base_install_docfiles() {
	debug-print-function ${FUNCNAME} "$@"
	local doc docdir
	[[ -n "$TMP_DOCDIR" ]] && docdir="$TMP_DOCDIR"
	[[ -n "$1" ]] && docdir="$1"
	[[ -z "$docdir" ]] && die "docdir is not set in ${FUNCNAME}."

	pushd "${docdir}" >/dev/null
	find . -maxdepth 1 -type f | while read doc; do
		einfo "Installing documentation: ${doc##*/}"
		dodoc "${doc}"
	done
	popd >/dev/null
}

EXPORT_FUNCTIONS src_configure src_install
