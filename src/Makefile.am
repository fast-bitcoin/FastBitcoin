# Copyright (c) 2013-2016 The Fastbitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS)
AM_CXXFLAGS = $(HARDENED_CXXFLAGS) $(ERROR_CXXFLAGS)
AM_CPPFLAGS = $(HARDENED_CPPFLAGS)
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

FASTBITCOIN_CONFIG_INCLUDES=-I$(builddir)/config
FASTBITCOIN_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

FASTBITCOIN_INCLUDES += -I$(srcdir)/secp256k1/include
FASTBITCOIN_INCLUDES += $(UNIVALUE_CFLAGS)

LIBFASTBITCOIN_SERVER=libfastbitcoin_server.a
LIBFASTBITCOIN_COMMON=libfastbitcoin_common.a
LIBFASTBITCOIN_CONSENSUS=libfastbitcoin_consensus.a
LIBFASTBITCOIN_CLI=libfastbitcoin_cli.a
LIBFASTBITCOIN_UTIL=libfastbitcoin_util.a
LIBFASTBITCOIN_CRYPTO=crypto/libfastbitcoin_crypto.a
LIBFASTBITCOINQT=qt/libfastbitcoinqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBFASTBITCOIN_ZMQ=libfastbitcoin_zmq.a
endif
if BUILD_FASTBITCOIN_LIBS
LIBFASTBITCOINCONSENSUS=libfastbitcoinconsensus.la
endif
if ENABLE_WALLET
LIBFASTBITCOIN_WALLET=libfastbitcoin_wallet.a
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBFASTBITCOIN_CRYPTO) \
  $(LIBFASTBITCOIN_UTIL) \
  $(LIBFASTBITCOIN_COMMON) \
  $(LIBFASTBITCOIN_CONSENSUS) \
  $(LIBFASTBITCOIN_SERVER) \
  $(LIBFASTBITCOIN_CLI) \
  $(LIBFASTBITCOIN_WALLET) \
  $(LIBFASTBITCOIN_ZMQ)

lib_LTLIBRARIES = $(LIBFASTBITCOINCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_FASTBITCOIND
  bin_PROGRAMS += fastbitcoind
endif

if BUILD_FASTBITCOIN_UTILS
  bin_PROGRAMS += fastbitcoin-cli fastbitcoin-tx
endif

.PHONY: FORCE check-symbols check-security
# fastbitcoin core #
FASTBITCOIN_CORE_H = \
  activemasternode.h \
  addrdb.h \
  addrman.h \
  base58.h \
  bloom.h \
  blockencodings.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  httprpc.h \
  httpserver.h \
  indirectmap.h \
  init.h \
  key.h \
  keepass.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  masternode.h \
  masternode-pos.h \
  masternodeman.h \
  masternodeconfig.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  noui.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  pow.h \
  protocol.h \
  random.h \
  reverselock.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/register.h \
  scheduler.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  script/ismine.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  spork.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util.h \
  utilmoneystr.h \
  utiltime.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libfastbitcoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between fastbitcoind and fastbitcoin-qt
libfastbitcoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libfastbitcoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_server_a_SOURCES = \
  activemasternode.cpp \
  addrman.cpp \
  addrdb.cpp \
  bloom.cpp \
  blockencodings.cpp \
  bitpool.cpp \
  chain.cpp \
  checkpoints.cpp \
  httprpc.cpp \
  httpserver.cpp \
  init.cpp \
  dbwrapper.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/policy.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  script/ismine.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(FASTBITCOIN_CORE_H)

if ENABLE_ZMQ
libfastbitcoin_zmq_a_CPPFLAGS = $(FASTBITCOIN_INCLUDES) $(ZMQ_CFLAGS)
libfastbitcoin_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp
endif


# wallet: shared between fastbitcoind and fastbitcoin-qt, but only linked
# when wallet enabled
libfastbitcoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
libfastbitcoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_wallet_a_SOURCES = \
  activemasternode.cpp \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  policy/rbf.cpp \
  $(FASTBITCOIN_CORE_H)

# crypto primitives library
crypto_libfastbitcoin_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_CONFIG_INCLUDES)
crypto_libfastbitcoin_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libfastbitcoin_crypto_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/aes_helper.c \
  crypto/luffa.c \
  crypto/groestl.c \
  crypto/jh.c \
  crypto/echo.c \
  crypto/shavite.c \
  crypto/keccak.c \
  crypto/skein.c \
  crypto/fugue.c \
  crypto/hamsi.c \
  crypto/haval.c \
  crypto/shabal.c \
  crypto/whirlpool.c \
  crypto/sph_sha2big.c \
  crypto/bmw.c \
  crypto/simd.c \
  crypto/cubehash.c \
  crypto/blake.c \
  crypto/sph_blake.h \
  crypto/sph_bmw.h \
  crypto/sph_cubehash.h \
  crypto/sph_echo.h \
  crypto/sph_groestl.h \
  crypto/sph_jh.h \
  crypto/sph_keccak.h \
  crypto/sph_luffa.h \
  crypto/sph_shavite.h \
  crypto/sph_simd.h \
  crypto/sph_skein.h \
  crypto/sph_types.h \
  crypto/sph_fugue.h \
  crypto/sph_hamsi.h \
  crypto/sph_haval.h \
  crypto/sph_shabal.h \
  crypto/sph_sha2.h \
  crypto/sph_whirlpool.h 

# consensus: shared between all executables that validate any consensus rules.
libfastbitcoin_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
libfastbitcoin_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/fastbitcoinconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  utilstrencodings.cpp \
  utilstrencodings.h \
  version.h

# common: shared between fastbitcoind, and fastbitcoin-qt and non-server tools
libfastbitcoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
libfastbitcoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_common_a_SOURCES = \
  activemasternode.cpp \
  masternode.cpp \
  masternode-pos.cpp \
  masternodeconfig.cpp \
  masternodeman.cpp \
  amount.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  keystore.cpp \
  netaddress.cpp \
  netbase.cpp \
  protocol.cpp \
  scheduler.cpp \
  script/sign.cpp \
  script/standard.cpp \
  spork.cpp \
  warnings.cpp \
  $(FASTBITCOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libfastbitcoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
libfastbitcoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(FASTBITCOIN_CORE_H)

if GLIBC_BACK_COMPAT
libfastbitcoin_util_a_SOURCES += compat/glibc_compat.cpp
endif

# cli: shared between fastbitcoin-cli and fastbitcoin-qt
libfastbitcoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
libfastbitcoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libfastbitcoin_cli_a_SOURCES = \
  rpc/client.cpp \
  $(FASTBITCOIN_CORE_H)

nodist_libfastbitcoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# fastbitcoind binary #
fastbitcoind_SOURCES = fastbitcoind.cpp
fastbitcoind_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
fastbitcoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
fastbitcoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
fastbitcoind_SOURCES += fastbitcoind-res.rc
endif

fastbitcoind_LDADD = \
  $(LIBFASTBITCOIN_SERVER) \
  $(LIBFASTBITCOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBFASTBITCOIN_UTIL) \
  $(LIBFASTBITCOIN_WALLET) \
  $(LIBFASTBITCOIN_ZMQ) \
  $(LIBFASTBITCOIN_CONSENSUS) \
  $(LIBFASTBITCOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

fastbitcoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# fastbitcoin-cli binary #
fastbitcoin_cli_SOURCES = fastbitcoin-cli.cpp
fastbitcoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES) $(EVENT_CFLAGS)
fastbitcoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
fastbitcoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
fastbitcoin_cli_SOURCES += fastbitcoin-cli-res.rc
endif

fastbitcoin_cli_LDADD = \
  $(LIBFASTBITCOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBFASTBITCOIN_UTIL) \
  $(LIBFASTBITCOIN_CRYPTO)

fastbitcoin_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# fastbitcoin-tx binary #
fastbitcoin_tx_SOURCES = fastbitcoin-tx.cpp
fastbitcoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(FASTBITCOIN_INCLUDES)
fastbitcoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
fastbitcoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
fastbitcoin_tx_SOURCES += fastbitcoin-tx-res.rc
endif

fastbitcoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBFASTBITCOIN_COMMON) \
  $(LIBFASTBITCOIN_UTIL) \
  $(LIBFASTBITCOIN_CONSENSUS) \
  $(LIBFASTBITCOIN_CRYPTO) \
  $(LIBSECP256K1)

fastbitcoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# fastbitcoinconsensus library #
if BUILD_FASTBITCOIN_LIBS
include_HEADERS = script/fastbitcoinconsensus.h
libfastbitcoinconsensus_la_SOURCES = $(crypto_libfastbitcoin_crypto_a_SOURCES) $(libfastbitcoin_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libfastbitcoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libfastbitcoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libfastbitcoinconsensus_la_LIBADD = $(LIBSECP256K1)
libfastbitcoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_FASTBITCOIN_INTERNAL
libfastbitcoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = $(CTAES_DIST)

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) -c -o $@ $<

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
