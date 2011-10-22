# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: alexander
# Purpose: make easy to install trinity ebuilds. 
#

inherit cmake-utils trinity-base

set-kmmodule() {
	debug-print-function $FUNCNAME "$@"

	local item

	if [[ -z "$KMMODULE" ]]; then
		export KMMODULE="$PN"
	fi

	for item in $KMMODULE; do
		item="$(echo $KMMODULE | tr 'a-z' 'A-Z')"
		[[ " $KMMODULE " == *" $item "*  ]] ||	export KMMODULE_CMAKE="$KMMODULE_CMAKE $item"
	done

}

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

# !!! temporary workaround

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
				S="${WORKDIR}/${P}"
				mkdir -p "${S}"
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
# Also see KMMODULE, KMNOMODULE, KMEXTRA, KMCOMPILEONLY, KMEXTRACTONLY and
# KMTARPARAMS.
trinity-meta_src_extract() {
	debug-print-function ${FUNCNAME} "$@"

	trinity-meta_create_extractlists

	if [[ ${BUILD_TYPE} = live ]]; then
		# Export working copy to ${S}
		einfo "Exporting parts of working copy to ${S}"

		case ${KDE_SCM} in
			svn)
				local rsync_options subdir targetdir wc_path escm

				rsync_options="--group --links --owner --perms --quiet --exclude=.svn/ --exclude=.git/"
				wc_path="${ESVN_WC_PATH}"
				escm="{ESVN}"
				# Copy ${KMNAME} non-recursively (toplevel files)
				rsync ${rsync_options} "${wc_path}"/* "${S}" \
					|| die "${escm}: can't export toplevel files to '${S}'."
				# Copy cmake and admin directory
				if [[ -d "${wc_path}/cmake" ]]; then
					rsync --recursive ${rsync_options} "${wc_path}/cmake" "${S}" \
						|| die "${escm}: can't export cmake files to '${S}'."
				fi

				# Copy all subdirectories
				for obj in ${KMEXTRACT}; do
					rsync --recursive ${rsync_options} "${wc_path}/${obj%/}" "${S}" \
						|| die "${escm}: can't export object '${obj}' to '${S}'."
				done
				;;
		esac
	else
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
# Create lists of files and subdirectories to extract.
# Also see descriptions of KMMODULE, KMOMODULE, KMEXTRACT and KMAIN_DOCS.
trinity-meta_create_extractlists() {
	debug-print-function ${FUNCNAME} "$@"
	
	$KMEXTRACT
	# add package-specific files and directories
	case ${KMNAME} in
		kdebase)
			KMEXTRACT+="
				kcontrol
				kdmlib"
			;;
		*)
			die "KMNAME ${KMNAME} is not supported by function ${FUNCNAME}"
	esac
	KMEXTRACT+="
		${KMMODULE}"

	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: KMEXTRACT ${KMEXTRACT}"
}



# !!! temporary workaround
trinity-meta_src_prepare() {
	if [[ "$KMNAME" == "kdebase" ]]; then
#		mv krootbacking/{krootbacking.cpp,krootbacking.h} kscreensaver/
#		mv krootbacking/main.cpp  kscreensaver/krootbackingmain.cpp
#		rm krootbacking/CMakeLists.txt
#		rmdir krootbacking/
		cat >${T}/fix-kdebase-cmake.patch <<'EOF' 
--- CMakeLists.txt.orig	2011-10-20 01:33:03.260813526 +0400
+++ CMakeLists.txt	2011-10-20 01:33:59.489685176 +0400
@@ -124,6 +124,8 @@
 option( BUILD_NSPLUGINS "Build nsplugins"  ${BUILD_ALL} )
 option( BUILD_KSYSGUARD "Build ksysguard"  ${BUILD_ALL} )
 option( BUILD_KXKB "Build kxkb"  ${BUILD_ALL} )
+option( BUILD_TSAK "Build tsak"  ${BUILD_ALL} )
+option( BUILD_KROOTBACKING "Build krootbacking"  ${BUILD_ALL} )
 
 
 ##### set PKG_CONFIG_PATH #######################
@@ -194,9 +196,9 @@
 tde_conditional_add_subdirectory( BUILD_NSPLUGINS nsplugins )
 tde_conditional_add_subdirectory( BUILD_KSYSGUARD ksysguard )
 tde_conditional_add_subdirectory( BUILD_KXKB kxkb )
-add_subdirectory( tsak )
-add_subdirectory( krootbacking )
-add_subdirectory( tqt3integration )
+tde_conditional_add_subdirectory( BUILD_TSAK tsak )
+tde_conditional_add_subdirectory( BUILD_KROOTBACKING krootbacking )
+#add_subdirectory( tqt3integration ) 
 
 ##### install startkde & related stuff ##########
 
--- kdmlib/CMakeLists.txt.orig	2011-10-20 01:33:24.512182370 +0400
+++ kdmlib/CMakeLists.txt	2011-10-20 01:30:07.474750978 +0400
@@ -73,9 +73,11 @@
 
 ##### kompmgr (executable) #######################
 
-tde_add_executable( kdmtsak
-  SOURCES kdmtsak.cpp
-  LINK ${TQT_LIBRARIES}
-  DESTINATION ${BIN_INSTALL_DIR}
-  SETUID
-)
\ В конце файла нет новой строки
+if( BUILD_TSAK )
+  tde_add_executable( kdmtsak
+    SOURCES kdmtsak.cpp
+    LINK ${TQT_LIBRARIES}
+    DESTINATION ${BIN_INSTALL_DIR}
+    SETUID
+  )
+endif( BUILD_TSAK )
EOF
		cd ${S}
		epatch ${T}/fix-kdebase-cmake.patch
	fi
}

trinity-meta_src_configure() {
	local item
	local kmmoduleargs

	debug-print
	for item in $KMMODULE_CMAKE; do
		kmmoduleargs+=" -DBUILD_${item}=ON"
	done

	mycmakeargs=(
		"${mycmakeargs[@]}"
		${kmmoduleargs}
	)

	trinity-base_src_configure
}

EXPORT_FUNCTIONS src_configure src_prepare src_unpack pkg_setup
