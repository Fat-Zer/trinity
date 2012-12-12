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
# Sets the right TRINITY_VER, TDEDIR and PATH variables...
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
		TRINITY_VER="$1"
	else
		TRINITY_VER="$PV"
	fi

	TRINITY_VER=$(get_version_component_range 1-2 ${TRINITY_VER})
	[[ "$TRINITY_VER" = "9999" ]] && export TRINITY_VER="${TRINITY_LIVEVER}"


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
	# adjust paths to see only current trinity version
	export PATH="${TDEDIR}/bin:$(echo ${PATH} \
			| sed 's#/usr/trinity/[^/]*/s\?bin/\?\(:\|$\)##g;s/:\+$//')"
	export LDPATH="${TDEDIR}/lib:$(echo "${LDPATH}" \
			| sed 's#/usr/trinity/[^/]*/lib/\?\(:\|$\)##g;s/:\+$//')"
	export LD_LIBRARY_PATH="${TDEDIR}/lib:$(echo "${LD_LIBRARY_PATH}" \
			| sed 's#/usr/trinity/[^/]*/lib/\?\(:\|$\)##g;s/:\+$//')"
}
