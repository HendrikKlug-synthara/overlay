# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python package to handle probe layout, geometry and wiring to device"
HOMEPAGE="https://github.com/SpikeInterface/probeinterface"
SRC_URI="https://github.com/SpikeInterface/probeinterface/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# Requires network access:
		# https://github.com/SpikeInterface/probeinterface/issues/70
		tests/test_library.py::test_download_probeinterface_file
		tests/test_library.py::test_get_from_cache
		tests/test_library.py::test_get_probe
		tests/test_wiring.py::test_wire_probe
	)
	epytest tests
}
