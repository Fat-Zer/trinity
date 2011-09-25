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
	set-kmmodule;

	export S=${WORKDIR}/${KMNAME}
}

# !!! temporary workaround
trinity-meta_src_prepare() {
	if [[ "$KMNAME" == "kdebase" ]]; then
#		mv krootbacking/{krootbacking.cpp,krootbacking.h} kscreensaver/
#		mv krootbacking/main.cpp  kscreensaver/krootbackingmain.cpp
#		rm krootbacking/CMakeLists.txt
#		rmdir krootbacking/
		cat >${T}/fix-kdebase-cmake.patch <<'EOF' 
--- CMakeLists.txt.orig	2011-09-18 09:53:17.076918001 +0400
+++ CMakeLists.txt	2011-09-18 09:57:09.904273180 +0400
@@ -124,6 +124,8 @@
 option( BUILD_NSPLUGINS "Build nsplugins"  ${BUILD_ALL} )
 option( BUILD_KSYSGUARD "Build ksysguard"  ${BUILD_ALL} )
 option( BUILD_KXKB "Build kxkb"  ${BUILD_ALL} )
+option( BUILD_TSAK "Build tsak"  ${BUILD_ALL} )
+option( BUILD_KROOTBACKING "Build krootbacking"  ${BUILD_ALL} )
 
 
 ##### set PKG_CONFIG_PATH #######################
@@ -194,8 +196,8 @@
 tde_conditional_add_subdirectory( BUILD_NSPLUGINS nsplugins )
 tde_conditional_add_subdirectory( BUILD_KSYSGUARD ksysguard )
 tde_conditional_add_subdirectory( BUILD_KXKB kxkb )
-add_subdirectory( tsak )
-add_subdirectory( krootbacking )
+tde_conditional_add_subdirectory( BUILD_TSAK tsak )
+tde_conditional_add_subdirectory( BUILD_KROOTBACKING krootbacking )
 
 ##### install startkde & related stuff ##########
 
--- kdmlib/CMakeLists.txt.orig	2011-09-18 10:02:47.888180964 +0400
+++ kdmlib/CMakeLists.txt	2011-09-18 18:11:06.188485674 +0400
@@ -73,9 +73,13 @@
 
 ##### kompmgr (executable) #######################
 
-tde_add_executable( kdmtsak
-  SOURCES kdmtsak.cpp
-  LINK ${TQT_LIBRARIES}
-  DESTINATION ${BIN_INSTALL_DIR}
-  SETUID
-)
\ В конце файла нет новой строки
+if( BUILD_TSAK )
+
+  tde_add_executable( kdmtsak
+    SOURCES kdmtsak.cpp
+    LINK ${TQT_LIBRARIES}
+    DESTINATION ${BIN_INSTALL_DIR}
+    SETUID
+  )
+
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



EXPORT_FUNCTIONS src_configure src_prepare pkg_setup
