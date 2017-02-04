# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="kdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity: Modeler for POV-Ray Scenes."
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/freetype-2.3"
RDEPEND="${DEPEND}
	media-gfx/povray"
