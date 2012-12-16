# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: alexander
# Purpose: basic trinity functions and variables
#

inherit versionator

TRINITY_LIVEVER="14.0"

# @FUNCTION: set-trinityver
# @USAGE: < version >
# @DESCRIPTION:
# Sets the right TRINITY_VER, TDEDIR etc...
# !!! unfinished
set-trinityver() {
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
		ETRINITY_VER="$1"
	else
		ETRINITY_VER="$PV"
	fi
	
	case "$ETRINITY_VER" in
		3.* ) 
			export TRINITY_VER="$(get_version_component_range 1-2 "${ETRINITY_VER}")" ;;
		9999 ) 
			export TRINITY_VER="$(get_major_version "$TRINITY_LIVEVER" )" ;;
		* ) 
			export TRINITY_VER="$(get_major_version "$ETRINITY_VER" )" ;;
	esac

	export TDEDIR="/usr/trinity/${TRINITY_VER}"
	export TDEDIRS="/usr/trinity/${TRINITY_VER}"

	# 3.5.x still uses KDE* variables
	if [ "${TRINITY_VER}" = "3.5" ]; then
		export KDEDIR="$TDEDIR"
		export KDEDIRS="$TDEDIRS"
	fi
	
	# this sould solve problems like "cannot find libraries" espessialy when
	# compiling kdelibs
	if [ -z "${LD_LIBRARY_PATH##*:${TDEDIR}/lib:*}" ]; then
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH%:}:${TDEDIR}/lib"
	fi
}

# @FUNCTION: adjust-trinity-paths
# @USAGE: < version >
# @DESCRIPTION:
# Adjust PATH LDPATH and LD_LIBRARY_PATH to see only current trinity version
adjust-trinity-paths() {
	debug-print-function $FUNCNAME "$@"
	
	# this function can be called during depend phase so we shouldn't use sed here
	PATH="$(trinity_remove_path_component "$PATH" "/usr/trinity/*/bin")"
	PATH="$(trinity_remove_path_component $PATH "/usr/trinity/*/sbin")"
	PATH="${TDEDIR}/bin:${PATH}"	
	LDPATH="$(trinity_remove_path_component $LDPATH "/usr/trinity/*/lib")"
	LDPATH="$(trinity_remove_path_component $LDPATH "/usr/trinity/*/lib32")"
	LDPATH="$(trinity_remove_path_component $LDPATH "/usr/trinity/*/lib64")"
	LDPATH="${TDEDIR}/lib:${LDPATH}"
	LD_LIBRARY_PATH="$(trinity_remove_path_component $LD_LIBRARY_PATH "/usr/trinity/*/lib")"
	LD_LIBRARY_PATH="$(trinity_remove_path_component $LD_LIBRARY_PATH "/usr/trinity/*/lib32")"
	LD_LIBRARY_PATH="$(trinity_remove_path_component $LD_LIBRARY_PATH "/usr/trinity/*/lib64")"
	LD_LIBRARY_PATH="${TDEDIR}/lib:${LD_LIBRARY_PATH}"
}

trinity_remove_path_component() {
	local i new_path path_array

	IFS=: read -ra path_array <<< "$1"
	for i in "${path_array[@]}"; do
		case "$i" in
			$2 ) ;; # delete specyfied entry
			"" ) ;;
			* ) new_path="${new_path}:${i}" ;;
		esac
	done

	echo "${new_path#:}"
}

# @FUNCTION: need-trinity
# @USAGE: < version >
# @DESCRIPTION:
# Sets the correct DEPEND and RDEPEND for the needed trinity < version >.
need-trinity() {
	debug-print-function $FUNCNAME "$@"

	local my_depend
	
	# determine install locations
	set-trinityver $1
	adjust-trinity-paths

	case "$1" in
		3.5*) 
			my_depend=">=kdelibs-${ETRINITY_VER}:3.5";; 
		*) 
			my_depend=">=kdelibs-${ETRINITY_VER}:${TRINITY_VER}";;
	esac

	DEPEND="$DEPEND $my_depend"
	RDEPEND="$RDEPEND $my_depend"
}
