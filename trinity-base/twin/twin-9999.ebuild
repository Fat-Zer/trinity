# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta eutils

DESCRIPTION="Trinity window manager"
KEYWORDS=
IUSE="xcomposite xrandr xinerama +libconfig +pcre opengl"

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-proto/xineramaproto )
	xrandr? ( x11-libs/libXrandr )
	libconfig? ( dev-libs/libconfig )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre[jit] )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xcomposite XCOMPOSITE)
		$(cmake-utils_use_with xcomposite XFIXES)
		$(cmake-utils_use_with xcomposite XRENDER)
		$(cmake-utils_use_with xrandr XRANDR)
		$(cmake-utils_use_with libconfig LIBCONFIG)
		$(cmake-utils_use_with pcre PCRE)
		$(cmake-utils_use_with xinerama XINERAMA)
	)

	trinity-meta_src_configure
}

pkg_postinst() {
	if ! use xcomposite; then
		for flag in xrandr xinerama libconfig pcre opengl; do
			use $flag && \
				ewarn "USE=\"$flag\" is passed, but it doesn't change anything due to" && \
				ewarn "$flag support in ${P} take effect only if composite is enabled."
		done

	fi
}
