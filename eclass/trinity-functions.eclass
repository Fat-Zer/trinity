# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Alexander Golubev (Fat-Zer)
# Purpose: basic trinity functions and variables
#

inherit versionator multilib

TRINITY_LIVEVER="14.0.0"

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
	# NOTE: That can breaks compilation of tdelibs:
	#       binaries which runs during compilation are tring to load shared
	#       libraries from the TDE's directory wich may be broken.
	# TODO: fix that issue for tdelibs
	adjust-trinity-paths
}

# @FUNCTION: get-trinity-libdirs
# @USAGE:
# @DESCRIPTION:
# lists all the trinity library directories
get-trinity-libdirs() {
	local rv
	for libdir in $(get_all_libdirs); do
		echo " ${TDEDIR}/${libdir}"
	done
}

# @FUNCTION: adjust-trinity-paths
# @USAGE: < version >
# @DESCRIPTION:
# Adjust PATH LDPATH and LD_LIBRARY_PATH to see only current trinity version
adjust-trinity-paths() {
	debug-print-function $FUNCNAME "$@"
	local libdir

	# this function can be called during depend phase so we shouldn't use sed here
	PATH="$(trinity_remove_path_component "$PATH" "/usr/trinity/*/bin")"
	PATH="$(trinity_remove_path_component "$PATH" "/usr/trinity/*/sbin")"
	PATH="$(trinity_prepand_path_component "$PATH" "${TDEDIR}/bin" )"

	# FIXME: it seems we don't need LDPATH
#	LDPATH="$(trinity_remove_path_component "$LDPATH" "/usr/trinity/*/${libdir}")"
	LD_LIBRARY_PATH="$(trinity_remove_path_component "$LD_LIBRARY_PATH" "/usr/trinity/*/${libdir}")"
	for libdir in $(get-trinity-libdirs); do
#		LDPATH="$(trinity_prepand_path_component "$LDPATH" "${TDEDIR}/${libdir}" )"
		LD_LIBRARY_PATH="$(trinity_prepand_path_component "$LD_LIBRARY_PATH" "${libdir}" )"
	done

	export PATH
	export LD_LIBRARY_PATH

	# Unset home paths so aplications wouldn't try to write to root's dir while build
	unset TDEHOME
	unset TDEROOTHOME
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

trinity_prepand_path_component() {
	local new_path

	new_path="${2%:}:${1#:}"
	echo "${new_path%:}"
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
			my_depend=">=trinity-base/kdelibs-${ETRINITY_VER}:3.5";;
		*)
			my_depend=">=trinity-base/tdelibs-${ETRINITY_VER}:${TRINITY_VER}";;
	esac

	DEPEND="$DEPEND $my_depend"
	RDEPEND="$RDEPEND $my_depend"
}

# @ECLASS-VARIABLE: TRINITY_NEED_ARTS
# @DESCRIPTION:
# This variable is setted by need-arts function. Possible arguments values 'yes', 'no' and 'optional'
# Default is 'no'
TRINITY_NEED_ARTS="no"

# @FUNCTION: need-arts
# @USAGE: need-arts <yes|optional>
# @DESCRIPTION:
# This function adds DEPEND's for aRTs-support Possible arguments are 'yes' and 'optinal'
# 'yes' means arts is required, optional' results in USE flag arts.
# NOTE: this function modifies IUSE DEPEND and RDEPEND variables, so if you call it before setting
#       those variables don't forget to include the priviously setted value into them.
need-arts() {
	debug-print-function $FUNCNAME "$@"

	local tdelibs my_depend

	[[ -z "${1}" ]] && die "$FUNCNAME requires an argument"

	TRINITY_NEED_ARTS=$1;

	case "${TRINITY_VER}" in
		"") die "You must call set-trinityver unctions to set TRINITY_VER before calling $FUNCNAME.";;
		3.5*) tdelibs="trinity-base/kdelibs";;
		*) tdelibs="trinity-base/tdelibs";;
	esac

	# handle trinity-base/tdelibs in special way
	if [[ "${CATEGORY}/${PN}" == "${tdelibs}" ]]; then
		if [[ "$1" == optional ]]; then
			my_depend=" arts? ( trinity-base/arts )"
			IUSE+=" arts"
		else
			die "aRTs support for ${tdelibs} supposed to be optional"
		fi
	else
		case "$1" in
			yes) my_depend=" trinity-base/arts
					${tdelibs}[arts]" ;;
			optional) my_depend=" arts? ( trinity-base/arts
					${tdelibs}[arts] )"
				IUSE+=" arts" ;;
			*) die "bad parameter: $1"
		esac
	fi

	DEPEND+=" ${my_depend}";
	RDEPEND+=" ${my_depend}";
}

