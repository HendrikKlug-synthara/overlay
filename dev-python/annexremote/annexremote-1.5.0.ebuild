# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

MY_PN="AnnexRemote"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper module to easily develop git-annex remotes"
HOMEPAGE="https://github.com/Lykos153/AnnexRemote"
SRC_URI="https://github.com/Lykos153/AnnexRemote/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

RDEPEND="dev-python/future[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all
	dodoc README.md
	use examples && dodoc -r examples
}
