# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#CMAKE_MAKEFILE_GENERATOR="emake"
PYTHON_COMPAT=( python3_{8..10} )

inherit cmake distutils-r1 git-r3 multilib ninja-utils

GTS_HASH="962155a01f5a1b87bd64e3e3d880b4dbc2347ac7"
NIFTI_HASH="65f801b9c2f1f15f4de4a19d45e6595c25765632"
GIFTI_HASH="5eae81ba1e87ef3553df3b6ba585f12dc81a0030"

DESCRIPTION="Advanced Normalitazion Tools for neuroimaging"
HOMEPAGE="http://stnava.github.io/ANTs/"
SRC_URI="
	https://github.com/leej3/gts/archive/${GTS_HASH}.tar.gz
	https://github.com/NIFTI-Imaging/nifti_clib/archive/${NIFTI_HASH}.tar.gz
	https://github.com/NIFTI-Imaging/gifti_clib/archive/${GIFTI_HASH}.tar.gz
	"
EGIT_REPO_URI="https://github.com/leej3/afni.git"
EGIT_BRANCH="make_some_build_fixes_for_gentoo_packaging"

SLOT="0"
LICENSE="GPL-3+"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libf2c
	dev-libs/expat
	dev-util/ninja
	media-libs/freeglut
	media-libs/glu
	media-libs/netpbm
	media-libs/qhull
	media-video/mpeg-tools
	sci-libs/gsl
	sys-devel/llvm:*
	sys-libs/libomp
	dev-libs/libpthread-stubs
	virtual/jpeg-compat:62
	x11-libs/libGLw
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt
	x11-libs/motif[-static-libs]
	"
DEPEND="
	${RDEPEND}
	app-shells/tcsh
	"
# Prospectively:
#sci-libs/gts
#Update jpeg-compat to virtual/jpeg:0
# look for xmhtlm

src_prepare() {
	tar xf "${DISTDIR}/${GTS_HASH}.tar.gz" || die
	tar xf "${DISTDIR}/${NIFTI_HASH}.tar.gz" || die
	tar xf "${DISTDIR}/${GIFTI_HASH}.tar.gz" || die
	cmake_src_prepare
	default
	}

src_configure() {
	#LDFLAGS="-L${S}/${LIBDIR} ${LDFLAGS}" econf --enable-progpath="${EPREFIX}/usr/bin"
	export CFLAGS="-pthread ${CFLAGS}"
	export GIT_REPO_VERSION=3.0.1.1
	#export LDFLAGS="-lpthread ${LDFLAGS}"
	#-CC="$(tc-getCC)"
	local mycmakeargs=(
		-GNinja
		-DLIBDIR=/usr/$(get_libdir)
		-DNIFTI_INSTALL_LIBRARY_DIR=/usr/$(get_libdir)
		-DGIFTI_INSTALL_LIBRARY_DIR=/usr/$(get_libdir)
		-DAFNI_INSTALL_LIBRARY_DIR=/usr/$(get_libdir)
		-DCMAKE_INSTALL_LIBDIR=/usr/$(get_libdir)
		-DCOMP_COREBINARIES=ON
		-DUSE_SYSTEM_NIFTI=OFF
		-DUSE_SYSTEM_GIFTI=OFF
		-DUSE_SYSTEM_XMHTML=OFF
		-DUSE_SYSTEM_GTS=OFF
		-DFETCHCONTENT_SOURCE_DIR_GTS="${WORKDIR}/${P}/gts-${GTS_HASH}"
		-DFETCHCONTENT_SOURCE_DIR_NIFTI_CLIB="${WORKDIR}/${P}/nifti_clib-${NIFTI_HASH}"
		-DFETCHCONTENT_SOURCE_DIR_GIFTI_CLIB="${WORKDIR}/${P}/gifti_clib-${GIFTI_HASH}"
		-DCOMP_GUI=ON
		-DCOMP_PLUGINS=ON
		-DUSE_OMP=ON
		-DCOMP_PYTHON=OFF
		-DPython_FIND_VIRTUALENV=STANDARD
		-DPython_FIND_STRATEGY=LOCATION
	)
	tc-export CC
	cmake_src_configure
}

src_compile() {
	cd ../afni-9999_build
	pwd
	ls -la
	eninja || die
}

#/work/afni-9999/nifti_clib-65f801b9c2f1f15f4de4a19d45e6595c25765632

src_install() {
	cd ../afni-9999_build
	DESTDIR=${D} eninja install
	#BUILD_DIR="${WORKDIR}/${P}_build/ANTS-build"
	#cmake_src_install
	#cd "${S}/Scripts" || die "scripts dir not found"
	#dobin *.sh
	#dodir /usr/$(get_libdir)/ants
	#insinto "/usr/$(get_libdir)/ants"
	#doins *
	#doenvd "${FILESDIR}"/99ants
}
