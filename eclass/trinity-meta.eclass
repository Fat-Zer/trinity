# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: fat-zer
# Purpose: make easy to install trinity ebuilds. 
#

inherit trinity-base trinity-functions cmake-utils

LICENSE="GPL-2 LGPL-2"
HOMEPAGE="http://www.trinitydesktop.org/"

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
trinity-meta_set_trinity_submodule() {
	debug-print-function $FUNCNAME "$@"

	if [[ -z "$TRINITY_SUBMODULE" ]]; then
		TRINITY_SUBMODULE="${PN#${TRINITY_MODULE_NAME}-}"
	fi
}

# @FUNCTION: trinity-meta_src_pkg_setup
# @DESCRIPTION:
# Default pkg_setup function. It sets the correct ${S}
# nessecary files.
trinity-meta_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"
	adjust-trinity-paths

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

	if [[ "${BUILD_TYPE}" = live ]]; then
		einfo "Exporting parts of working copy to ${S}"
		case "$TRINITY_SCM" in
			svn) trinity-meta_rsync_copy ;;
			git) # we nothing can do to prevent git from unpacking code
				;;
			*)  die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}"
		esac
	else
		local tarfile tarparams f extractlist

		case $TRINITY_TARBALL in
			*.gz)
				tarparams=" --gzip"
				;;
			*.xz)
				tarparams=" --xz"
				;;
		esac

		# Full path to source tarball
		tarfile="${DISTDIR}/${TRINITY_TARBALL}"

		# Detect real toplevel dir from tarball name - it will be used upon extraction
		topdir="${TRINITY_TARBALL%.tar.*}"

		ebegin "Unpacking parts of ${TRINITY_TARBALL} to ${WORKDIR}"

		for f in $TSM_EXTRACT_LIST;	do
			extractlist+=" ${topdir}/${f}"
		done

		tar -xpf "${tarfile}" ${tarparams} -C "${WORKDIR}"  ${extractlist} 2> /dev/null  \
				|| echo "tar extract command failed at least partially - continuing anyway"

		# Make sure $S points to right place
		[[ "${WORKDIR}/${topdir}" != "${S}" ]] && S="${WORKDIR}/${topdir}"
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
	local submod
	
	# if $TSM_EXTRACT is not set assign it to dirs named in TRINITY_SUBMODULE
	if [ -z "${TSM_EXTRACT}" ]; then
		for submod in ${TRINITY_SUBMODULE}; do
			TSM_EXTRACT="${TSM_EXTRACT} ${submod}/"
		done
	fi

	# add package-specific files and directories
	case "${TRINITY_MODULE_NAME}" in
		kdebase) TSM_EXTRACT_LIST+=" kcontrol/ kdmlib/" ;;
		tdebase) TSM_EXTRACT_LIST+=" kcontrol/" ;;
		*) ;; # nothing special for over modules
#		*) die "TRINITY_MODULE_NAME ${TRINITY_MODULE_NAME} is not supported by function ${FUNCNAME}" ;;
	esac

	TSM_EXTRACT_LIST+=" ${TSM_EXTRACT} ${TSM_EXTRACT_ALSO} cmake/ CMakeLists.txt"
	TSM_EXTRACT_LIST+=" config.h.cmake ConfigureChecks.cmake"

 	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: TSM_EXTRACT_LIST=\"${TSM_EXTRACT_LIST}\""
}

# @FUNCTION: trinity-meta_src_prepare
# @DESCRIPTION:
# Default src prepare function. Currently it's only a stub.
trinity-meta_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"
	local shared_patch_dir f f_name;

	shared_patch_dir="${FILESDIR}/shared/${TRINITY_MODULE_NAME}-${PV}/patches/"
	if [ -d "${shared_patch_dir}" ]; then
		find "${shared_patch_dir}" -type f | while read f; do
			f_name="$(basename "${f}")"
			case "${f_name}" in
			*.diff | *.patch ) epatch "${f}" ;;
			*.gz ) cp "${f}" "${T}"
				gunzip ${T}/${f_name}
				epatch  ${T}/${f_name%.gz}
				;;
			*.bz2 ) cp "${f}" "${T}"
				bunzip2 ${T}/${f_name}
				epatch  ${T}/${f_name%.bz2}
				;;
			*) die "unknown patch type in the patch directory" ;;
			esac
		done;
	fi
	
# fix bad cmake code fo 3.5.13.1
	if [ $PV == "3.5.13.1" ]; then
		[ -f "cmake/modules/FindTDE.cmake" ] && \
			sed -ie 's!HINTS\s\+${\w*BIN\w*}!HINTS "${TDE_PREFIX}/bin" ${BIN_INSTALL_DIR}!' \
				cmake/modules/FindTDE.cmake
	fi
	
	trinity-base_src_prepare
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

# @FUNCTION: trinity-meta_src_compile
# @DESCRIPTION:
# Just call trinity-base_src_compile.
trinity-meta_src_compile() {
	debug-print-function ${FUNCNAME} "$@"
	
	trinity-base_src_compile
}

# @FUNCTION: trinity-meta_src_install
# @DESCRIPTION:
# Call default cmake install function. and install documentation.
trinity-meta_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	
	TRINITY_BASE_NO_INSTALL_DOC="yes" trinity-base_src_install

	trinity-base_create_tmp_docfiles $TSM_EXTRACT
	trinity-base_install_docfiles
}

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install src_unpack pkg_setup
