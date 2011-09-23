# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: alexander
# Purpose: basic trinity functions and variables
#

inherit versionator

TRINITY_LIVEVER="3.5"

# @FUNCTION: set-kdever
# @USAGE: < version >
# @DESCRIPTION:
# Sets the right KDEVER, KDEDIR and PREFIX varyables...
# !!! unfinished
set-kdever() {
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
		KDEVER="$1"
	else
		KDEVER="$PV"
	fi

	export KDEVER=$(get_version_component_range 1-2 ${KDEVER})
	[[ "$KDEVER" = "3.9999" ]] && export KDEVER="${TRINITY_LIVEVER}"

	# install prefix
#	if [[ -n "$KDEPREFIX" ]]; then
#		export PREFIX="$KDEPREFIX"
#	else
		export PREFIX="/usr/kde/${KDEVER}"
#	fi

	# kdelibs location
#	if [[ -n "$KDELIBSDIR" ]]; then
#		export KDEDIR="$KDELIBSDIR"
#	else
		export KDEDIR="${PREFIX}"
#	fi
}

