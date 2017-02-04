# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta

DESCRIPTION="Trinity: Modeler for POV-Ray Scenes."
KEYWORDS=
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/freetype-2.3"
RDEPEND="${DEPEND}
	media-gfx/povray"
