# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: alexander
# Purpose: make easy to install trinity ebuilds. 
#

inherit cmake-utils trinity-base

LICENSE="GPL-2 LGPL-2"
HOMEPAGE="http://www.trinitydesktop.org/"

# ban EAPI 0 and 1
case $EAPI in
	0|1) die "EAPI=${EAPI} is not supported" ;;
	2|3|4) ;;
	*) ewarn "Unknown EAPI=${EAPI}"
esac

# set slot, KDEDIR, KDEVER and PREFIX
set-kdever
[[ -z "$SLOT" ]] && SLOT="$KDEVER"

# common dependencies
DEPEND="kde-base/kdelibs:${SLOT}"

set-kmmodule() {
	debug-print-function $FUNCNAME "$@"

	local item

	if [[ -z "$KMMODULE" ]]; then
		export KMMODULE="$PN"
	fi
}

trinity-meta_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"
	set-kmmodule;

	export S=${WORKDIR}/${KMNAME}
}

trinity-meta_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${BUILD_TYPE} = live ]]; then
		case "${KDE_SCM}" in
			svn)
				ESVN_RESTRICT="export" subversion_src_unpack
				subversion_wc_info
				subversion_bootstrap
				;;
			git)
				git-2_src_unpack
				;;
		esac
	fi
	trinity-meta_src_extract
}

# @FUNCTION: trinity-meta_src_extract
# @DESCRIPTION:
# A function to extract the source for a split KDE ebuild.
# Also see KMMODULE, KMEXTRACT
trinity-meta_src_extract() {
	debug-print-function ${FUNCNAME} "$@"

	trinity-meta_create_extractlists

	if [[ ${BUILD_TYPE} = live ]]; then
		einfo "Exporting parts of working copy to ${S}"
		trinity-meta_rsync_copy
	else
		die "BUILD_TYPE=$BUILD_TYPE is not supported by function ${S}"
		eerror "relese extract is complitly untested"
		local abort tarball tarfile f extractlist postfix
#
#		KMTARPARAMS+=" --bzip2"
#		postfix="bz2"
#
#		case ${KMNAME} in
#			kdebase-apps)
#				# kdebase/apps -> kdebase-apps
#				tarball="kdebase-${PV}.tar.${postfix}"
#				;;
#			*)
#				# Create tarball name from module name (this is the default)
#				tarball="${KMNAME}-${PV}.tar.${postfix}"
#				;;
#		esac
#
#		# Full path to source tarball
#		tarfile="${DISTDIR}/${tarball}"
#
#		# Detect real toplevel dir from tarball name - it will be used upon extraction
#		# and in __list_needed_subdirectories
#		topdir="${tarball%.tar.*}/"
#
#		ebegin "Unpacking parts of ${tarball} to ${WORKDIR}"
#
#		kde4-meta_create_extractlists
#
#		for f in cmake/ CMakeLists.txt ConfigureChecks.cmake config.h.cmake
#		do
#			extractlist+=" ${topdir}${f}"
#		done
#		extractlist+=" $(__list_needed_subdirectories)"
#
#		pushd "${WORKDIR}" > /dev/null
#
#		# @ECLASS-VARIABLE: KDE4_STRICTER
#		# @DESCRIPTION:
#		# Print out all issues found executing tar / kmextract files
#		# Set on if you want to find issues in kde-base ebuild unpack sequences
#		[[ -n ${KDE4_STRICTER} ]] && echo 'tar -xpf "${tarfile}" ${KMTARPARAMS} ${extractlist}'
#		if [[ ${I_KNOW_WHAT_I_AM_DOING} ]]; then
#			# to make the devs happy - bug 338397
#			tar -xpf "${tarfile}" ${KMTARPARAMS} ${extractlist} || ewarn "tar extract command failed at least partially - continuing anyway"
#		else
#			tar -xpf "${tarfile}" ${KMTARPARAMS} ${extractlist} 2> /dev/null || echo "tar extract command failed at least partially - continuing anyway"
#		fi
#
#		# Default $S is based on $P; rename the extracted directory to match $S if necessary
#		if [[ ${KMNAME} != ${PN} ]]; then
#			mv ${topdir} ${P} || die "Died while moving \"${topdir}\" to \"${P}\""
#		fi
#
#		popd > /dev/null
#
#		eend $?
#
#		if [[ -n ${KDE4_STRICTER} ]]; then
#			for f in $(__list_needed_subdirectories fatal); do
#				if [[ ! -e ${S}/${f#*/} ]]; then
#					eerror "'${f#*/}' is missing"
#					abort=true
#				fi
#			done
#			[[ -n ${abort} ]] && die "There were missing files."
#		fi
#
#		# We don't need it anymore
#		unset topdir
	fi
}

# @FUNCTION: trinity-meta_create_extractlists
# @DESCRIPTION:
# Copies files from svn (and later git repository) to $S
trinity-meta_rsync_copy() {
	debug-print-function ${FUNCNAME} "$@"

	local rsync_options subdir targetdir wc_path escm
	case "${KDE_SCM}" in
	svn) wc_path="${ESVN_WC_PATH}";;
#	git) wc_path="${EGIT_DIR}";;
	*)   die "Unsupported KDE_SCM: ${KDE_SCM} is not supported by ${FUNCNAME}"
		;;
	esac

	rsync_options="--group --links --owner --perms --quiet --exclude=.svn/ --exclude=.git/"

	# Copy ${KMNAME} non-recursively (toplevel files)
	rsync ${rsync_options} "${wc_path}"/* "${S}" \
		|| die "rsync: can't export toplevel files to '${S}'."
	# Copy cmake directory
	if [[ -d "${wc_path}/cmake" ]]; then
		rsync --recursive ${rsync_options} "${wc_path}/cmake" "${S}" \
			|| die "rsync: can't export cmake files to '${S}'."
	fi

	# Copy all subdirectories listed in $KMEXTRACT
	for subdir in ${KMEXTRACT}; do
		rsync --recursive ${rsync_options} "${wc_path}/${subdir}" "${S}" \
			|| die "rsync: can't export object '${obj}' to '${S}'."
	done
}

# @FUNCTION: trinity-meta_create_extractlists
# @DESCRIPTION:
# Create lists of files and subdirectories to extract.
# Also see descriptions of KMMODULE, KMOMODULE, KMEXTRACT and KMAIN_DOCS.
trinity-meta_create_extractlists() {
	debug-print-function ${FUNCNAME} "$@"

	# if $KMEXTRACT is not set assign it kmmodule
	[ -z ${KMEXTRACT} ] && KMEXTRACT="${KMMODULE}"
	# add package-specific files and directories
	case ${KMNAME} in
		kdebase)
			KMEXTRACT+=" kcontrol kdmlib" ;;
		*)
			die "KMNAME ${KMNAME} is not supported by function ${FUNCNAME}" ;;
	esac

	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: KMEXTRACT ${KMEXTRACT}"
}

# @FUNCTION: trinity-meta_src_prepare
# @DESCRIPTION:
# Default src prepare function. Currently it's only a stub.
trinity-meta_src_prepare() {

}

# @FUNCTION: trinity-meta_src_configure
# @DESCRIPTION:
# Default source configure function. It sets apropriate cmake args.
# Also see description of KMMODULE
trinity-meta_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	local item, kmmoduleargs

	for item in $KMMODULE; do
		kmmoduleargs+=" -DBUILD_${item^^}=ON"
	done

	mycmakeargs=(
		"${mycmakeargs[@]}"
		${kmmoduleargs}
	)

	trinity-base_src_configure
}

EXPORT_FUNCTIONS src_configure src_prepare pkg_setup
