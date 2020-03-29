# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A program for screen recording of wlroots-based compositors"
HOMEPAGE="https://github.com/ammen99/wf-recorder"

SRC_URI="https://github.com/ammen99/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	media-video/ffmpeg
	media-sound/pulseaudio
"
BDEPEND="
	virtual/pkgconfig
	dev-libs/wayland-protocols
"
