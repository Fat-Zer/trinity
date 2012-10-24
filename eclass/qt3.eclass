# Copyright 2005-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/qt3.eclass,v 1.41 2009/05/17 15:17:03 hwoarang Exp $

# @ECLASS: qt3.eclass
# @MAINTAINER:
# kde-sunset overlay maintainers
# @BLURB: Eclass for Qt3 packages
# @DESCRIPTION:
# This eclass contains various functions that may be useful
# when dealing with packages using Qt3 libraries.

inherit toolchain-funcs versionator eutils

if [[ -z "${QTDIR}" ]]; then
	export QTDIR="/usr/qt/3"
fi

addwrite "${QTDIR}/etc/settings"
addpredict "${QTDIR}/etc/settings"

# @FUNCTION: eqmake3
# @USAGE: [.pro file] [additional parameters to qmake]
# @MAINTAINER:
# Przemyslaw Maciag <troll@gentoo.org>
# Davide Pesavento <davidepesa@gmail.com>
# @DESCRIPTION:
# Runs qmake on the specified .pro file (defaults to
# ${PN}.pro if eqmake3 was called with no argument).
# Additional parameters are passed unmodified to qmake.
eqmake3() {
	local LOGFILE="${T}/qmake-$$.out"
	local projprofile="${1}"
	[[ -z ${projprofile} ]] && projprofile="${PN}.pro"
	shift 1

	ebegin "Processing qmake ${projprofile}"

	# file exists?
	if [[ ! -f ${projprofile} ]]; then
		echo
		eerror "Project .pro file \"${projprofile}\" does not exist"
		eerror "qmake cannot handle non-existing .pro files"
		echo
		eerror "This shouldn't happen - please send a bug report to bugs.gentoo.org"
		echo
		die "Project file not found in ${PN} sources"
	fi

	echo >> ${LOGFILE}
	echo "******  qmake ${projprofile}  ******" >> ${LOGFILE}
	echo >> ${LOGFILE}

	# some standard config options
	local configoptplus="CONFIG += no_fixpath"
	local configoptminus="CONFIG -="
	if has debug ${IUSE} && use debug; then
		configoptplus="${configoptplus} debug"
		configoptminus="${configoptminus} release"
	else
		configoptplus="${configoptplus} release"
		configoptminus="${configoptminus} debug"
	fi

	${QTDIR}/bin/qmake ${projprofile} \
		QTDIR=${QTDIR} \
		QMAKE=${QTDIR}/bin/qmake \
		QMAKE_CC=$(tc-getCC) \
		QMAKE_CXX=$(tc-getCXX) \
		QMAKE_LINK=$(tc-getCXX) \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CFLAGS_DEBUG="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_CXXFLAGS_DEBUG="${CXXFLAGS}" \
		QMAKE_LFLAGS_RELEASE="${LDFLAGS}" \
		QMAKE_LFLAGS_DEBUG="${LDFLAGS}" \
		"${configoptminus}" \
		"${configoptplus}" \
		QMAKE_RPATH= \
		QMAKE_STRIP= \
		${@} >> ${LOGFILE} 2>&1

	local result=$?
	eend ${result}

	# was qmake successful?
	if [[ ${result} -ne 0 ]]; then
		echo
		eerror "Running qmake on \"${projprofile}\" has failed"
		echo
		eerror "This shouldn't happen - please send a bug report to bugs.gentoo.org"
		echo
		die "qmake failed on ${projprofile}"
	fi

	return ${result}
}
