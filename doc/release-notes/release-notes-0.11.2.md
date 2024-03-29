0.11.2 Release notes
====================


Fastbitcoin Core version 0.11.2 is now available from:

  https://fastbitcoin.eu

Please report bugs using the issue tracker at github:

  https://github.com/BSD-SUPPORT/Fastbitcoin


Mining and relay policy enhancements
------------------------------------

Fastbitcoin Core's block templates are now for version 3 blocks only, and any
mining software relying on its `getblocktemplate` must be updated in parallel
to use libblkmaker either version 0.4.2 or any version from 0.5.1 onward. If you
are solo mining, this will affect you the moment you upgrade Fastbitcoin Core,
which must be done prior to BIP66 achieving its 951/1001 status. If you are
mining with the stratum mining protocol: this does not affect you. If you are
mining with the getblocktemplate protocol to a pool: this will affect you at the
pool operator's discretion, which must be no later than BIP66 achieving its
951/1001 status.


BIP 66: strict DER encoding for signatures
------------------------------------------

Fastbitcoin Core 0.11.2 implements BIP 66, which introduces block version 3, and a
new consensus rule, which prohibits non-DER signatures. Such transactions have
been non-standard since Fastbitcoin 0.8, but were technically still permitted
inside blocks.

This change breaks the dependency on OpenSSL's signature parsing, and is
required if implementations would want to remove all of OpenSSL from the
consensus code.

The same miner-voting mechanism as in BIP 34 is used: when 751 out of a
sequence of 1001 blocks have version number 3 or higher, the new consensus
rule becomes active for those blocks. When 951 out of a sequence of 1001
blocks have version number 3 or higher, it becomes mandatory for all blocks.

Backward compatibility with current mining software is NOT provided, thus
miners should read the first paragraph of "Mining and relay policy
enhancements" above.

Also compare with [upstream release notes](https://github.com/fastbitcoin/fastbitcoin/blob/0.10/doc/release-notes.md#mining-and-relay-policy-enhancements).

More info on [BIP 66](https://github.com/fastbitcoin/bips/blob/master/bip-0066.mediawiki).


How to Upgrade
--------------

If you are running an older version, shut it down. Wait until it has completely
shut down (which might take a few minutes for older versions), then run the
installer (on Windows) or just copy over /Applications/Fastbitcoin-Qt (on Mac) or
fastbitcoind/fastbitcoin-qt (on Linux).


0.11.2 changelog
----------------
- Fastbitcoin Core 0.11.2.17 is forked off the Dash Core 0.11.2.17. Please feel free and compare against forks https://github.com/dashpay
- The old fastbitcoin version 0.9.1.4 was forked from the Darkcoin 0.9.1.0 tree, done by iparn https://github.com/IParn/Fastbitcoin
- The first limecoin currency is full implemented in the BSD chain, done by iparn https://github.com/IParn/limecoin
- The following changes are introduced in this major release. 

Fastbitcoin Core:

- Rebrand to Fastbitcoin Core
- Version bumped to 0.11.2.17 to indicate a new major release
- Renamed client to identify with network from Satoshi to Core
- Bumped protocol version to 70075
- Masternode with 5000 BSD
- NEW Reward = 40 BSD per Miner/Pool & 10 BSD per Masternode
- NEW RPC PORT 8800 and NEW P2P Port Default 3336
- Changed testnet address versions 
- Defined BIP32 (HD) address versions
- Adapted BIP44 coin type 5 for Fastbitcoin (0x80000005) as defined in SLIP-0044
- Added new units: limes (1 / 100.000.000 BSD)
- Added units for testnet: tBSD, mtBSD, uBSD, tlimes
- Fixed wallet locking after sending coins
- Add -regtest mode, similar to testnet but private with instant block generation with setgenerate RPC.
- Add separate fastbitcoin-cli client
- - Implemented KeyPass integration for CLI, RPC and Qt: keepass, keepassport, keepasskey, keepassid, keepassname
- Masternodes:

Masternodes:

- Improve support for start-many with multi masternode config
- New masternode rpc commands: stop-many, start-alias, stop-alias, list-conf
- Fixed possible masternode payments exploit
- Better support for non-specific masternode payments
- Added masternode support for regtest
- Randomly sort masternodes before picking next winner
- Show number of masternodes in debug window


Darksend:

- Reduced lower darksend limit to 1.5 BSD
- Fixed progress bar calculation for low amounts
- Improved support for adding BSD after anon has completed
- Added denomination information to Overview tab
- Added more detailed Darksend status information to Overview tab
- Added Darksend high precision matching engine
- Added Darksend balance to `getinfo`
- Changed maximum rounds of mixing to 16


RPC:

- Add `getwalletinfo`, `getblockchaininfo` and `getnetworkinfo` calls
  (will replace hodge-podge `getinfo` at some point)
- Add a `relayfee` field to `getnetworkinfo`
- Always show syncnode in `getpeerinfo`
- `sendrawtransaction`: report the reject code and reason, and make it possible
  to re-send transactions that are already in the mempool
- `getmininginfo` show right genproclimit
- New notion of 'conflicted' transactions, reported as confirmations: -1
- 'listreceivedbyaddress' now provides tx ids
- Add raw transaction hex to 'gettransaction' output
- Updated help and tests for 'getreceivedby(account|address)'
- In 'getblock', accept 2nd 'verbose' parameter, similar to getrawtransaction,
  but defaulting to 1 for backward compatibility
- Add 'verifychain', to verify chain database at runtime
- Add 'dumpwallet' and 'importwallet' RPCs
- 'keypoolrefill' gains optional size parameter
- Add 'getbestblockhash', to return tip of best chain
- Add 'chainwork' (the total work done by all blocks since the genesis block)
  to 'getblock' output
- Make RPC password resistant to timing attacks
- Clarify help messages and add examples
- Add 'getrawchangeaddress' call for raw transaction change destinations
- Reject insanely high fees by default in 'sendrawtransaction'
- Add RPC call 'decodescript' to decode a hex-encoded transaction script
- Make 'validateaddress' provide redeemScript
- Add 'getnetworkhashps' to get the calculated network hashrate
- New RPC 'ping' command to request ping, new 'pingtime' and 'pingwait' fields
  in 'getpeerinfo' output
- Adding new 'addrlocal' field to 'getpeerinfo' output
- Add verbose boolean to 'getrawmempool'
- Add rpc command 'getunconfirmedbalance' to obtain total unconfirmed balance
- Explicitly ensure that wallet is unlocked in `importprivkey`
- Add check for valid keys in `importprivkey`
- Disable SSLv3 (in favor of TLS) for the RPC client and server.


Command-line options:

- Fix `-printblocktree` output
- Show error message if ReadConfigFile fails
- New option: -nospendzeroconfchange to never spend unconfirmed change outputs
- New option: -zapwallettxes to rebuild the wallet's transaction information
- Rename option '-tor' to '-onion' to better reflect what it does
- Add '-disablewallet' mode to let fastbitcoind run entirely without wallet (when
  built with wallet)
- Update default '-rpcsslciphers' to include TLSv1.2
- make '-logtimestamps' default on and rework help-message
- RPC client option: '-rpcwait', to wait for server start
- Remove '-logtodebugger'
- Allow `-noserver` with fastbitcoind
- Make -proxy set all network types, avoiding a connect leak.


Block-chain handling and storage:

- Upgrade leveldb to 1.17
- Check for correct genesis (prevent cases where a datadir from the wrong
  network is accidentally loaded)
- Allow txindex to be removed and add a reindex dialog
- Log aborted block database rebuilds
- Store orphan blocks in serialized form, to save memory
- Limit the number of orphan blocks in memory to 750
- Fix non-standard disconnected transactions causing mempool orphans


Protocol and network code:

- Don't poll showmyip.com, it doesn't exist anymore
- Add a way to limit deserialized string lengths and use it
- Increase IsStandard() scriptSig length
- Avoid querying DNS seeds, if we have open connections
- Remove a useless millisleep in socket handler
- Stricter memory limits on CNode
- Better orphan transaction handling
- Add `-maxorphantx=<n>` and `-maxorphanblocks=<n>` options for control over the
  maximum orphan transactions and blocks
- Per-peer block download tracking and stalled download detection
- Prevent socket leak in ThreadSocketHandler and correct some proxy related
  socket leaks
- Use pnode->nLastRecv as sync score (was the wrong way around)
- Drop the fee required to relay a transaction to 0.01mDRK per kilobyte
- Send tx relay flag with version
- New 'reject' P2P message (BIP 0061, see
  https://gist.github.com/gavinandresen/7079034 for draft)
- Dump addresses every 15 minutes instead of 10 seconds
- Relay OP_RETURN data TxOut as standard transaction type
- Remove CENT-output free transaction rule when relaying
- Lower maximum size for free transaction creation
- Send multiple inv messages if mempool.size > MAX_INV_SZ
- Split MIN_PROTO_VERSION into INIT_PROTO_VERSION and MIN_PEER_PROTO_VERSION
- Do not treat fFromMe transaction differently when broadcasting
- Process received messages one at a time without sleeping between messages
- Improve logging of failed connections
- Add some additional logging to give extra network insight
- Limit the number of new addressses to accumulate


Wallet:

- Check redeemScript size does not exceed 520 byte limit
- Ignore (and warn about) too-long redeemScripts while loading wallet
- Make GetAvailableCredit run GetHash() only once per transaction (performance
  improvement)
- Lower paytxfee warning threshold
- Fix importwallet nTimeFirstKey (trigger necessary rescans)
- Log BerkeleyDB version at startup
- CWallet init fix
- Bug fixes and new regression tests to correctly compute
  the balance of wallets containing double-spent (or mutated) transactions
- Store key creation time. Calculate whole-wallet birthday.
- Optimize rescan to skip blocks prior to birthday
- Let user select wallet file with -wallet=foo.dat
- Don't count txins for priority to encourage sweeping
- Don't create empty transactions when reading a corrupted wallet
- Fix rescan to start from beginning after importprivkey


Mining:

- Increase default -blockmaxsize/prioritysize to 750K/50K
- 'getblocktemplate' does not require a key to create a block template
- Mining code fee policy now matches relay fee policy


GUI:

- fix 'opens in testnet mode when presented with a BIP-72 link with no fallback'
- AvailableCoins: acquire cs_main mutex
- Fix unicode character display on MacOSX
- Fix various coin control visual issues
- Show number of in/out connections in debug console
- Show weeks as well as years behind for long timespans behind
- Enable and disable the Show and Remove buttons for requested payments history
  based on whether any entry is selected.
- Show also value for options overridden on command line in options dialog
- Fill in label from address book also for URIs
- Fixes feel when resizing the last column on tables
- Fix ESC in disablewallet mode
- Add expert section to wallet tab in optionsdialog
- Do proper boost::path conversion (fixes unicode in datadir)
- Only override -datadir if different from the default (fixes -datadir in config
  file)
- Show rescan progress at start-up
- Show importwallet progress
- Get required locks upfront in polling functions (avoids hanging on locks)
- Catch Windows shutdown events while client is running
- Optionally add third party links to transaction context menu
- Check for !pixmap() before trying to export QR code (avoids crashes when no QR
  code could be generated)
- Fix "Start fastbitcoin on system login"
- Switch to Qt 5.2.0 for Windows build
- Add payment request (BIP 0070) support
- Improve options dialog
- Show transaction fee in new send confirmation dialog
- Add total balance in overview page
- Allow user to choose data directory on first start, when data directory is
  missing, or when the -choosedatadir option is passed
- Save and restore window positions
- Add vout index to transaction id in transactions details dialog
- Add network traffic graph in debug window
- Add open URI dialog
- Improve receive coins workflow: make the 'Receive' tab into a form to request
  payments, and move historical address list functionality to File menu.
- Move initialization/shutdown to a thread. This prevents "Not responding"
  messages during startup. Also show a window during shutdown.
- Don't regenerate autostart link on every client startup
- Show and store message of normal fastbitcoin:URI
- Fix richtext detection hang issue on very old Qt versions
- OS X: Make use of the 10.8+ user notification center to display Growl-like
  notifications
- OS X: Added NSHighResolutionCapable flag to Info.plist for better font
  rendering on Retina displays.
- OS X: Fix fastbitcoin-qt startup crash when clicking dock icon
- Linux: Fix Gnome fastbitcoin: URI handler


Validation:

- Log reason for non-standard transaction rejection
- Prune provably-unspendable outputs, and adapt consistency check for it.
- Detect any sufficiently long fork and add a warning
- Call the -alertnotify script when we see a long or invalid fork
- Fix multi-block reorg transaction resurrection
- Reject non-canonically-encoded serialization sizes
- Reject dust amounts during validation
- Accept nLockTime transactions that finalize in the next block
- consensus: guard against openssl's new strict DER checks
- fail immediately on an empty signature
- Improve robustness of DER recoding code


Build system:

- Add OSX build descriptors to gitian
- Fix explicit --disable-qt-dbus
- Don't require db_cxx.h when compiling with wallet disabled and GUI enabled
- Improve missing boost error reporting
- gitian-linux: --enable-glibc-back-compat for binary compatibility with old
  distributions
- gitian: don't export any symbols from executable
- gitian: build against Qt 4.6
- devtools: add script to check symbols from Linux gitian executables
- Remove build-time no-IPv6 setting
- Add statically built executables to Linux build
- Switch to autotools-based build system
- Build without wallet by passing `--disable-wallet` to configure, this
  removes the BerkeleyDB dependency
- Upgrade gitian dependencies (libpng, libz, libupnpc, boost, openssl) to more
  recent versions
- Windows 64-bit build support
- Solaris compatibility fixes
- Check integrity of gitian input source tarballs
- Enable full GCC Stack-smashing protection for all OSes
- build: Fix OSX build when using Homebrew and qt5
- Keep symlinks when copying into .app bundle
- osx: fix signing to make Gatekeeper happy (again)


Miscellaneous:

- key.cpp: fail with a friendlier message on missing ssl EC support
- Remove bignum dependency for scripts
- Upgrade OpenSSL to 1.0.1i, includes CVE-2014-0224, CVE-2014-0160 and
  CVE-2014-0076 (see https://www.openssl.org/news/secadv_20140806.txt)
- Upgrade miniupnpc to 1.9.20140701
- Fix boost detection in build system on some platforms
- Replace non-threadsafe C functions (gmtime, strerror and setlocale)
- Add missing cs_main and wallet locks
- Avoid exception at startup when system locale not recognized
- devtools: add a script to fetch and postprocess translations
- Refactor -alertnotify code
- doc: Add instructions for consistent Mac OS X build names


Credits
--------

Thanks to who contributed to this release, at least:

- *to do ..*

As well as everyone that helped translating on [Transifex](https://www.transifex.com/projects/p/fastbitcoin/).
