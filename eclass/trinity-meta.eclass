# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: make easy to install trinity ebuilds. 
#

inherit trinity-base trinity-functions cmake-utils qt3

LICENSE="GPL-2 LGPL-2"
HOMEPAGE="http://www.trinitydesktop.org/"

# ban EAPI 0 and 1
case $EAPI in
	0|1|2) die "EAPI=${EAPI} is not supported" ;;
	3|4) ;;
	*) ewarn "Unknown EAPI=${EAPI}"
esac

# set slot, TDEDIR, TRINITY_VER and PREFIX
set-trinityver
[[ -z "$SLOT" ]] && SLOT="$TRINITY_VER"

if [[ "$TRINITY_VER" == "3.5" ]]; then
# common dependencies
	DEPEND="trinity-base/kdelibs:${SLOT}"
else
	DEPEND="trinity-base/tdelibs:${SLOT}"
fi

# @FUNCTION: trinity-meta_set_trinity_submodule
# @DESCRIPTION:
# sets the TRINITY_SUBMODULE variable to vth value aptained from ${PN}
# if it doesn't set yet
# Default pkg_setup function. It sets the correct ${S}
# nessecary files.
trinity-meta_set_trinity_submodule() {
	debug-print-function $FUNCNAME "$@"

	if [[ -z "$TRINITY_SUBMODULE" ]]; then
		TRINITY_SUBMODULE="${PN#${TRINITY_MODULE_NAME}-}"
	fi
}

# @FUNCTION: trinity-meta_src_unpack
# @DESCRIPTION:
# Default pkg_setup function. It sets the correct ${S}
# nessecary files.
trinity-meta_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"
	trinity-meta_set_trinity_submodule
}

# @FUNCTION: trinity-meta_src_unpack
# @DESCRIPTION:
# Default source extract function. It tries to unpack only 
# nessecary files.
trinity-meta_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ ${BUILD_TYPE} = live ]]; then
		case "${TRINITY_SCM}" in
			svn)
				mkdir -p "$S"
				ESVN_RESTRICT="export" subversion_src_unpack
				subversion_wc_info
				subversion_bootstrap
				;;
			git)
				git-2_src_unpack
				;;
			*)   die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}" ;;
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
		case "$TRINITY_SCM" in
			svn) trinity-meta_rsync_copy ;;
			git) # we nothing can do to prevent git from unpacking code
			     # so we will just fix the default ${S} variable
				[[ "${WORKDIR}" != "${S}" ]] && mv "${WORKDIR}" "${S}" ;;
			*)  die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}"
		esac
	else
		local tarball tarfile tarparams f extractlist postfix

		tarparams=" --gzip"
		postfix="gz"

		tarball="${TRINITY_MODULE_NAME}-${PV}.tar.${postfix}"

		# Full path to source tarball
		tarfile="${DISTDIR}/${tarball}"

		# Detect real toplevel dir from tarball name - it will be used upon extraction
		topdir="${tarball%.tar.*}"

		ebegin "Unpacking parts of ${tarball} to ${WORKDIR}"

		for f in $EXTRACT_LIST;	do
			extractlist+=" ${topdir}/${f}"
		done

		tar -xpf "${tarfile}" ${tarparams} -C ${WORKDIR}  ${extractlist} 2> /dev/null  \
				|| echo "tar extract command failed at least partially - continuing anyway"

		# Default $S is based on $P; rename the extracted directory to match $S if necessary
		if [[ ${TRINITY_MODULE_NAME} != ${PN} ]]; then
			mv ${WORKDIR}/${topdir} ${P} || die "Died while moving \"${topdir}\" to \"${P}\""
		fi
	fi
}

# @FUNCTION: trinity-meta_rsync_copy 
# @DESCRIPTION:
# Copies files from svn or git repository to $S
trinity-meta_rsync_copy() {
	debug-print-function ${FUNCNAME} "$@"

	local rsync_options subdir targetdir wc_path escm
	case "${TRINITY_SCM}" in
		svn) wc_path="${ESVN_WC_PATH}";;
		git) wc_path="${EGIT_STORE_DIR}/${EGIT_PROJECT}";;
		*)   die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}" ;;
	esac

	rsync_options="--group --links --owner --perms --quiet --exclude=.svn/ --exclude=.git/"

	# Copy ${TRINITY_MODULE_NAME} non-recursively (toplevel files)
	rsync ${rsync_options} "${wc_path}"/* "${S}" \
		|| die "rsync: can't export toplevel files to '${S}'."
	# Copy cmake directory
	if [[ -d "${wc_path}/cmake" ]]; then
		rsync --recursive ${rsync_options} "${wc_path}/cmake" "${S}" \
			|| die "rsync: can't export cmake files to '${S}'."
	fi
	# Copy all subdirectories listed in $TSM_EXTRACT_LIST
	for subdir in ${TSM_EXTRACT_LIST}; do
		rsync --recursive ${rsync_options} "${wc_path}/${subdir}" \
			"${S}/$(dirname subdir)" \
			|| die "rsync: can't export object '${wc_path}/${subdir}' to '${S}'."
	done
}

# @FUNCTION: trinity-meta_create_extractlists
# @DESCRIPTION:
# Create lists of files and subdirectories to extract.
# Also see descriptions of KMMODULE and KMEXTRACT 
trinity-meta_create_extractlists() {
	debug-print-function ${FUNCNAME} "$@"

	# if $TSMEXTRACT is not set assign it kmmodule
	[ -z "${TSM_EXTRACT}" ] && TSM_EXTRACT="${TRINITY_SUBMODULE}/"
	# add package-specific files and directories
	case "${TRINITY_MODULE_NAME}" in
		kdebase) TSM_EXTRACT_LIST+=" kcontrol/ kdmlib/" ;;
		tdebase) TSM_EXTRACT_LIST+=" kcontrol/" ;;
		kdeartwork) ;;
		tdeartwork) ;;
		tdegraphics) ;;
		*) die "TRINITY_MODULE_NAME ${TRINITY_MODULE_NAME} is not supported by function ${FUNCNAME}" ;;
	esac

	TSM_EXTRACT_LIST+=" ${TSM_EXTRACT} ${TSM_EXTRACT_ALSO} cmake/ CMakeLists.txt \
						config.h.cmake ConfigureChecks.cmake "
	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: TSM_EXTRACT_LIST ${TSM_EXTRACT_LIST}"
}

# @FUNCTION: trinity-meta_src_prepare
# @DESCRIPTION:
# Default src prepare function. Currently it's only a stub.
trinity-meta_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	if [ "${TRINITY_MODULE_NAME}" == "tdebase" ]; then
		# upstream CMakelists files are sometimes really crappy...
		cat >$T/tdebase-fix-migratekde3-install.patch <<'EOF'
--- tdebase/CMakeLists.txt.orig 2012-10-20 13:29:16.000000000 +0400
+++ tdebase/CMakeLists.txt      2012-10-21 04:03:09.000000000 +0400
@@ -219,8 +219,8 @@
 
 if( BUILD_STARTTDE )
   install( PROGRAMS starttde DESTINATION ${BIN_INSTALL_DIR} )
+  install( PROGRAMS migratekde3 r14-xdg-update DESTINATION ${BIN_INSTALL_DIR} )
 endif()
-install( PROGRAMS migratekde3 r14-xdg-update DESTINATION ${BIN_INSTALL_DIR} )
 
 
 ##### write configure files #####################
EOF
		epatch ${T}/tdebase-fix-migratekde3-install.patch
	fi

	trinity-base-src_prepare
}

# @FUNCTION: trinity-meta_src_configure
# @DESCRIPTION:
# Default source configure function. It sets apropriate cmake args.
# Also see description of KMMODULE
trinity-meta_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	local item tsmargs mod

	for item in $TRINITY_SUBMODULE; do
		mod="${item^^}"
		mod="${mod//-/_}"
		tsmargs+=" -DBUILD_${mod}=ON"
	done

	mycmakeargs=(
		"${mycmakeargs[@]}"
		${tsmargs}
	)

	trinity-base_src_configure
}

# @FUNCTION: trinity-meta_src_install
# @DESCRIPTION:
# Call default cmake install function. and install documentation.
trinity-meta_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	cmake-utils_src_install

	trinity-base_create_tmp_docfiles $TSM_EXTRACT
	trinity-base_install_docfiles
}

EXPORT_FUNCTIONS src_configure src_prepare src_install src_unpack pkg_setup
