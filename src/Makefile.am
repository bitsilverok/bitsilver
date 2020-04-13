# Copyright (c) 2013-2016 The BitSilver Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS) $(GPROF_LDFLAGS) $(SANITIZER_LDFLAGS)
AM_CXXFLAGS = $(DEBUG_CXXFLAGS) $(HARDENED_CXXFLAGS) $(WARN_CXXFLAGS) $(NOWARN_CXXFLAGS) $(ERROR_CXXFLAGS) $(GPROF_CXXFLAGS) $(SANITIZER_CXXFLAGS)
AM_CPPFLAGS = $(DEBUG_CPPFLAGS) $(HARDENED_CPPFLAGS)
AM_LIBTOOLFLAGS = --preserve-dup-deps
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

BITSILVER_INCLUDES=-I$(builddir) $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS)

BITSILVER_INCLUDES += -I$(srcdir)/secp256k1/include
BITSILVER_INCLUDES += $(UNIVALUE_CFLAGS)

LIBBITSILVER_SERVER=libbitsilver_server.a
LIBBITSILVER_COMMON=libbitsilver_common.a
LIBBITSILVER_CONSENSUS=libbitsilver_consensus.a
LIBBITSILVER_CLI=libbitsilver_cli.a
LIBBITSILVER_UTIL=libbitsilver_util.a
LIBBITSILVER_CRYPTO_BASE=crypto/libbitsilver_crypto_base.a
LIBBITSILVERQT=qt/libbitsilverqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBBITSILVER_ZMQ=libbitsilver_zmq.a
endif
if BUILD_BITSILVER_LIBS
LIBBITSILVERCONSENSUS=libbitsilverconsensus.la
endif
if ENABLE_WALLET
LIBBITSILVER_WALLET=libbitsilver_wallet.a
LIBBITSILVER_WALLET_TOOL=libbitsilver_wallet_tool.a
endif

LIBBITSILVER_CRYPTO= $(LIBBITSILVER_CRYPTO_BASE)
if ENABLE_SSE41
LIBBITSILVER_CRYPTO_SSE41 = crypto/libbitsilver_crypto_sse41.a
LIBBITSILVER_CRYPTO += $(LIBBITSILVER_CRYPTO_SSE41)
endif
if ENABLE_AVX2
LIBBITSILVER_CRYPTO_AVX2 = crypto/libbitsilver_crypto_avx2.a
LIBBITSILVER_CRYPTO += $(LIBBITSILVER_CRYPTO_AVX2)
endif
if ENABLE_SHANI
LIBBITSILVER_CRYPTO_SHANI = crypto/libbitsilver_crypto_shani.a
LIBBITSILVER_CRYPTO += $(LIBBITSILVER_CRYPTO_SHANI)
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*.h) $(wildcard secp256k1/src/*.c) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBBITSILVER_CRYPTO) \
  $(LIBBITSILVER_UTIL) \
  $(LIBBITSILVER_COMMON) \
  $(LIBBITSILVER_CONSENSUS) \
  $(LIBBITSILVER_SERVER) \
  $(LIBBITSILVER_CLI) \
  $(LIBBITSILVER_WALLET) \
  $(LIBBITSILVER_WALLET_TOOL) \
  $(LIBBITSILVER_ZMQ)

lib_LTLIBRARIES = $(LIBBITSILVERCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_BITSILVERD
  bin_PROGRAMS += bitsilverd
endif

if BUILD_BITSILVER_CLI
  bin_PROGRAMS += bitsilver-cli
endif
if BUILD_BITSILVER_TX
  bin_PROGRAMS += bitsilver-tx
endif
if ENABLE_WALLET
if BUILD_BITSILVER_WALLET
  bin_PROGRAMS += bitsilver-wallet
endif
endif

.PHONY: FORCE check-symbols check-security
# bitsilver core #
BITSILVER_CORE_H = \
  addrdb.h \
  addrman.h \
  attributes.h \
  banman.h \
  base58.h \
  bech32.h \
  bloom.h \
  blockencodings.h \
  blockfilter.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/assumptions.h \
  compat/byteswap.h \
  compat/cpuid.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  consensus/tx_check.h \
  consensus/tx_verify.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  flatfile.h \
  fs.h \
  httprpc.h \
  httpserver.h \
  index/base.h \
  index/blockfilterindex.h \
  index/txindex.h \
  indirectmap.h \
  init.h \
  interfaces/chain.h \
  interfaces/handler.h \
  interfaces/node.h \
  interfaces/wallet.h \
  key.h \
  key_io.h \
  dbwrapper.h \
  limitedmap.h \
  logging.h \
  logging/timer.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_permissions.h \
  net_processing.h \
  net_types.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  node/coin.h \
  node/coinstats.h \
  node/context.h \
  node/psbt.h \
  node/transaction.h \
  node/utxo_snapshot.h \
  noui.h \
  optional.h \
  outputtype.h \
  policy/feerate.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  policy/settings.h \
  pow.h \
  protocol.h \
  psbt.h \
  random.h \
  randomenv.h \
  reverse_iterator.h \
  rpc/blockchain.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/rawtransaction_util.h \
  rpc/register.h \
  rpc/request.h \
  rpc/server.h \
  rpc/util.h \
  scheduler.h \
  script/descriptor.h \
  script/keyorigin.h \
  script/sigcache.h \
  script/sign.h \
  script/signingprovider.h \
  script/standard.h \
  shutdown.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util/asmap.h \
  util/bip32.h \
  util/bytevectorhash.h \
  util/check.h \
  util/error.h \
  util/fees.h \
  util/spanparsing.h \
  util/system.h \
  util/macros.h \
  util/memory.h \
  util/message.h \
  util/moneystr.h \
  util/rbf.h \
  util/settings.h \
  util/string.h \
  util/threadnames.h \
  util/time.h \
  util/translation.h \
  util/url.h \
  util/vector.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  versionbitsinfo.h \
  walletinitinterface.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/feebumper.h \
  wallet/fees.h \
  wallet/ismine.h \
  wallet/load.h \
  wallet/rpcwallet.h \
  wallet/scriptpubkeyman.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  wallet/wallettool.h \
  wallet/walletutil.h \
  wallet/coinselection.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h \
  zmq/zmqrpc.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh "$(abs_top_builddir)/src/obj/build.h" \
	  "$(abs_top_srcdir)"
libbitsilver_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between bitsilverd and bitsilver-qt
# Contains code accessing mempool and chain state that is meant to be separated
# from wallet and gui code (see node/README.md). Shared code should go in
# libbitsilver_common or libbitsilver_util libraries, instead.
libbitsilver_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libbitsilver_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_server_a_SOURCES = \
  addrdb.cpp \
  addrman.cpp \
  banman.cpp \
  blockencodings.cpp \
  blockfilter.cpp \
  chain.cpp \
  consensus/tx_verify.cpp \
  flatfile.cpp \
  httprpc.cpp \
  httpserver.cpp \
  index/base.cpp \
  index/blockfilterindex.cpp \
  index/txindex.cpp \
  interfaces/chain.cpp \
  interfaces/node.cpp \
  init.cpp \
  dbwrapper.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  node/coin.cpp \
  node/coinstats.cpp \
  node/context.cpp \
  node/psbt.cpp \
  node/transaction.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/rbf.cpp \
  policy/settings.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  shutdown.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(BITSILVER_CORE_H)

if ENABLE_WALLET
libbitsilver_server_a_SOURCES += wallet/init.cpp
endif
if !ENABLE_WALLET
libbitsilver_server_a_SOURCES += dummywallet.cpp
endif

if ENABLE_ZMQ
libbitsilver_zmq_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES) $(ZMQ_CFLAGS)
libbitsilver_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp \
  zmq/zmqrpc.cpp
endif


# wallet: shared between bitsilverd and bitsilver-qt, but only linked
# when wallet enabled
libbitsilver_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_wallet_a_SOURCES = \
  interfaces/wallet.cpp \
  wallet/coincontrol.cpp \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/feebumper.cpp \
  wallet/fees.cpp \
  wallet/load.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/scriptpubkeyman.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  wallet/walletutil.cpp \
  wallet/coinselection.cpp \
  $(BITSILVER_CORE_H)

libbitsilver_wallet_tool_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_wallet_tool_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_wallet_tool_a_SOURCES = \
  wallet/wallettool.cpp \
  $(BITSILVER_CORE_H)

# crypto primitives library
crypto_libbitsilver_crypto_base_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libbitsilver_crypto_base_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libbitsilver_crypto_base_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/chacha_poly_aead.h \
  crypto/chacha_poly_aead.cpp \
  crypto/chacha20.h \
  crypto/chacha20.cpp \
  crypto/common.h \
  crypto/hkdf_sha256_32.cpp \
  crypto/hkdf_sha256_32.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/poly1305.h \
  crypto/poly1305.cpp \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/siphash.cpp \
  crypto/siphash.h

if USE_ASM
crypto_libbitsilver_crypto_base_a_SOURCES += crypto/sha256_sse4.cpp
endif

crypto_libbitsilver_crypto_sse41_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libbitsilver_crypto_sse41_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libbitsilver_crypto_sse41_a_CXXFLAGS += $(SSE41_CXXFLAGS)
crypto_libbitsilver_crypto_sse41_a_CPPFLAGS += -DENABLE_SSE41
crypto_libbitsilver_crypto_sse41_a_SOURCES = crypto/sha256_sse41.cpp

crypto_libbitsilver_crypto_avx2_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libbitsilver_crypto_avx2_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libbitsilver_crypto_avx2_a_CXXFLAGS += $(AVX2_CXXFLAGS)
crypto_libbitsilver_crypto_avx2_a_CPPFLAGS += -DENABLE_AVX2
crypto_libbitsilver_crypto_avx2_a_SOURCES = crypto/sha256_avx2.cpp

crypto_libbitsilver_crypto_shani_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libbitsilver_crypto_shani_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libbitsilver_crypto_shani_a_CXXFLAGS += $(SHANI_CXXFLAGS)
crypto_libbitsilver_crypto_shani_a_CPPFLAGS += -DENABLE_SHANI
crypto_libbitsilver_crypto_shani_a_SOURCES = crypto/sha256_shani.cpp

# consensus: shared between all executables that validate any consensus rules.
libbitsilver_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/tx_check.cpp \
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
  script/bitsilverconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  span.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  util/strencodings.cpp \
  util/strencodings.h \
  version.h

# common: shared between bitsilverd, and bitsilver-qt and non-server tools
libbitsilver_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_common_a_SOURCES = \
  base58.cpp \
  bech32.cpp \
  bloom.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  key_io.cpp \
  merkleblock.cpp \
  netaddress.cpp \
  netbase.cpp \
  net_permissions.cpp \
  outputtype.cpp \
  policy/feerate.cpp \
  policy/policy.cpp \
  protocol.cpp \
  psbt.cpp \
  rpc/rawtransaction_util.cpp \
  rpc/util.cpp \
  scheduler.cpp \
  script/descriptor.cpp \
  script/sign.cpp \
  script/signingprovider.cpp \
  script/standard.cpp \
  versionbitsinfo.cpp \
  warnings.cpp \
  $(BITSILVER_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libbitsilver_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity_fdelt.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  fs.cpp \
  interfaces/handler.cpp \
  logging.cpp \
  random.cpp \
  randomenv.cpp \
  rpc/request.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util/asmap.cpp \
  util/bip32.cpp \
  util/bytevectorhash.cpp \
  util/error.cpp \
  util/fees.cpp \
  util/system.cpp \
  util/message.cpp \
  util/moneystr.cpp \
  util/rbf.cpp \
  util/settings.cpp \
  util/threadnames.cpp \
  util/spanparsing.cpp \
  util/strencodings.cpp \
  util/string.cpp \
  util/time.cpp \
  util/url.cpp \
  $(BITSILVER_CORE_H)

if GLIBC_BACK_COMPAT
libbitsilver_util_a_SOURCES += compat/glibc_compat.cpp
AM_LDFLAGS += $(COMPAT_LDFLAGS)
endif

# cli: shared between bitsilver-cli and bitsilver-qt
libbitsilver_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
libbitsilver_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libbitsilver_cli_a_SOURCES = \
  compat/stdin.h \
  compat/stdin.cpp \
  rpc/client.cpp \
  $(BITSILVER_CORE_H)

nodist_libbitsilver_util_a_SOURCES = $(srcdir)/obj/build.h
#

# bitsilverd binary #
bitsilverd_SOURCES = bitsilverd.cpp
bitsilverd_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
bitsilverd_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
bitsilverd_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
bitsilverd_SOURCES += bitsilverd-res.rc
endif

bitsilverd_LDADD = \
  $(LIBBITSILVER_SERVER) \
  $(LIBBITSILVER_WALLET) \
  $(LIBBITSILVER_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBBITSILVER_UTIL) \
  $(LIBBITSILVER_ZMQ) \
  $(LIBBITSILVER_CONSENSUS) \
  $(LIBBITSILVER_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

bitsilverd_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# bitsilver-cli binary #
bitsilver_cli_SOURCES = bitsilver-cli.cpp
bitsilver_cli_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES) $(EVENT_CFLAGS)
bitsilver_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
bitsilver_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
bitsilver_cli_SOURCES += bitsilver-cli-res.rc
endif

bitsilver_cli_LDADD = \
  $(LIBBITSILVER_CLI) \
  $(LIBUNIVALUE) \
  $(LIBBITSILVER_UTIL) \
  $(LIBBITSILVER_CRYPTO)

bitsilver_cli_LDADD += $(BOOST_LIBS) $(EVENT_LIBS)
#

# bitsilver-tx binary #
bitsilver_tx_SOURCES = bitsilver-tx.cpp
bitsilver_tx_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
bitsilver_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
bitsilver_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
bitsilver_tx_SOURCES += bitsilver-tx-res.rc
endif

bitsilver_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBBITSILVER_COMMON) \
  $(LIBBITSILVER_UTIL) \
  $(LIBBITSILVER_CONSENSUS) \
  $(LIBBITSILVER_CRYPTO) \
  $(LIBSECP256K1)

bitsilver_tx_LDADD += $(BOOST_LIBS)
#

# bitsilver-wallet binary #
bitsilver_wallet_SOURCES = bitsilver-wallet.cpp
bitsilver_wallet_CPPFLAGS = $(AM_CPPFLAGS) $(BITSILVER_INCLUDES)
bitsilver_wallet_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
bitsilver_wallet_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
bitsilver_wallet_SOURCES += bitsilver-wallet-res.rc
endif

bitsilver_wallet_LDADD = \
  $(LIBBITSILVER_WALLET_TOOL) \
  $(LIBBITSILVER_WALLET) \
  $(LIBBITSILVER_COMMON) \
  $(LIBBITSILVER_CONSENSUS) \
  $(LIBBITSILVER_UTIL) \
  $(LIBBITSILVER_CRYPTO) \
  $(LIBBITSILVER_ZMQ) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1) \
  $(LIBUNIVALUE)

bitsilver_wallet_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(MINIUPNPC_LIBS) $(ZMQ_LIBS)
#

# bitsilverconsensus library #
if BUILD_BITSILVER_LIBS
include_HEADERS = script/bitsilverconsensus.h
libbitsilverconsensus_la_SOURCES = support/cleanse.cpp $(crypto_libbitsilver_crypto_base_a_SOURCES) $(libbitsilver_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libbitsilverconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libbitsilverconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libbitsilverconsensus_la_LIBADD = $(LIBSECP256K1)
libbitsilverconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_BITSILVER_INTERNAL
libbitsilverconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

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
CLEANFILES += obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/bitsilver-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/bitsilver-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/bitsilver-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/bitsilver-config.h.in

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

check-symbols: $(bin_PROGRAMS)
if TARGET_DARWIN
	@echo "Checking macOS dynamic libraries..."
	$(AM_V_at) OTOOL=$(OTOOL) $(PYTHON) $(top_srcdir)/contrib/devtools/symbol-check.py $(bin_PROGRAMS)
endif

if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(PYTHON) $(top_srcdir)/contrib/devtools/symbol-check.py $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) OTOOL=$(OTOOL) $(PYTHON) $(top_srcdir)/contrib/devtools/security-check.py $(bin_PROGRAMS)
endif

if EMBEDDED_LEVELDB
include Makefile.crc32c.include
include Makefile.leveldb.include
endif

include Makefile.test_util.include

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
