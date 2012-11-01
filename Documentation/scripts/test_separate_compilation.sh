#!/bin/bash
# !!!WARNING!!! use with caution 
#
# This script suppose the kdelibs to be installed
# how to use :
# dependecies_test_compilation <package>

die() {
	echo '!!! $@'
	exit -100500
}

PACKAGES=( $@ )

RESULT_DIR="/tmp/test-build-$(date +%Y-%m-%d_%H-%M)"
SUCCESS_LIST="${RESULT_DIR}/success_list"
FAIL_LIST="${RESULT_DIR}/fail_list"
LOGS_DIR="${RESULT_DIR}/logs/"
CONFIG_BAK="${RESULT_DIR}/portage_bak.tar.gz"
PORTAGE_CONFIG="/etc/portage"
EMERGE_AUTOUNMASK_OPTS="--autounmask y --autounmask-keep-masks y --autounmask-write y"
mkdir -p "${RESULT_DIR}" "${LOGS_DIR}";

# backup config
tar -cf "${CONFIG_BAK}" -C / "${PORTAGE_CONFIG#/}" || die "backup config failed"

# initial cleanup
( emerge -NuD world && 
  emerge --depclean && 
  emerge -NuD world && 
  revdep-rebuild && 
  rm -rf /var/tmp/portage ) || die "initial cleaning failed"

for pkg in "${PACKAGES[@]}"; do
	pkg_failed=no
	# check for it can be emerged due to depenencies uses
	emerge -p "$pkg"
	if [ "$?" != 0 ]; then
		#try unmask uses
		CONFIG_PROTECT_MASK="/etc/portage" emerge ${EMERGE_AUTOUNMASK_OPTS} "$pkg"
		emerge -p "$pkg"
		if [ "$?" != 0 ]; then
			# we can't emerge the package
			mkdir -p "${LOGS_DIR}/${pkg}"
			emerge -p "$pkg" >"${LOGS_DIR}/${pkg}/emerge_failed" 2>&1
			pkg_failed=yes
		fi
	fi

	if [ "$pkg_failed" == no ]; then
		emerge -1 "$pkg" 
		if [ "$?" != 0 ]; then
			mkdir -p "${LOGS_DIR}/${pkg}"
			for f_pkg in $(cd /var/tmp/portage/ && ls -d */*); do
				cp "/var/tmp/portage/${f_pkg}/temp/build.log" "${LOGS_DIR}/${pkg}/${f_pkg/\//_}.build"
			done
			pkg_failed=yes
		fi
	fi

	if [ "$pkg_failed" == no ]; then
		echo "$pkg" >>"${SUCCESS_LIST}"
	else
		echo "$pkg" >>"${FAIL_LIST}"
	fi
	
	# restoring config
	rm -rf ${PORTAGE_CONFIG}
	tar -xf "${CONFIG_BAK}" -C /

	# let's clean system
    ( emerge -NuD world && 
	  emerge --depclean && 
	  emerge -NuD world && 
	  revdep-rebuild && 
	  rm -rf /var/tmp/portage ) || die "cleaning failed"
done
