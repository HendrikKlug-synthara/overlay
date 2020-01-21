# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 virtualx

MY_P="widgets-${PV}"

DESCRIPTION="The new FSL image viewer, first released with FSL 5.0.10"
HOMEPAGE="https://git.fmrib.ox.ac.uk/fsl/fsleyes/fsleyes/tree/master"
SRC_URI="https://git.fmrib.ox.ac.uk/fsl/fsleyes/widgets/-/archive/${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		)
	dev-python/setuptools[${PYTHON_USEDEP}]
	"
RDEPEND="
	dev-python/deprecation[${PYTHON_USEDEP}]
	=dev-python/numpy-1*[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	=dev-python/six-1*[${PYTHON_USEDEP}]
	dev-python/wxpython[${PYTHON_USEDEP}]
	"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/fsleyes-widgets-0.8.4-coverage.patch"
	"${FILESDIR}/fsleyes-widgets-0.8.4-tests.patch"
)

python_test() {
	virtx pytest --verbose || die
}
