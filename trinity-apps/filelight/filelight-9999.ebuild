# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"
TRINITY_LANGS="az bg br ca cs cy da de el en_GB es et fr ga gl is it ja ka lt nb nl pl pt pt_BR ro ru rw sr sr@Latn sv ta tr uk"
TRINITY_DOC_LANGS=" da es et it pt ru sv"

inherit trinity-base

DESCRIPTION="Visualise disk usage with interactive map of concentric, segmented rings"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""

need-trinity 14.0.0

SLOT="${TRINITY_VER}"
