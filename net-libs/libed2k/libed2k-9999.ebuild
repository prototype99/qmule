EAPI=4
inherit git-2
DESCRIPTION="Edonkey 2000 lib"
HOMEPAGE="https://github.com/qmule/libed2k"
SLOT=0

EGIT_REPO_URI="git://github.com/qmule/libed2k.git"
EGIT_BRANCH="develop"

#todo set license
LICENSE="Oslik"

KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/boost-1.49.0
<dev-libs/boost-1.50.0
>=dev-libs/boost-logging-2.0.0
dev-libs/openssl
"

RDEPEND="${DEPEND}"
IUSE="debug"

pkg_setup() {
	export EXTRA_EMAKE="${EXTRA_EMAKE} BOOST_ROOT=/usr"		#gentoo exists
	export EXTRA_EMAKE="${EXTRA_EMAKE} LIBTORRENT_ROOT=/usr"	#gentoo exists

	use amd64 && export EXTRA_EMAKE="${EXTRA_EMAKE} DATA_MODEL=64"

	if use debug ; then
		elog "Debug mode on"
	else 
		export EXTRA_EMAKE="${EXTRA_EMAKE} PRODUCTION=1"
	fi
}
src_compile(){
	emake libed2k.a || die "emake failed"
}
src_install(){ 
	dolib "$S/lib/libed2k.a"
	insinto "/usr/include/"
	cd "$S/include/"
	doins -r *
}