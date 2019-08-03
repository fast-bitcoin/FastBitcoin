.PHONY: FORCE
all: FORCE
        $(MAKE) -C .. fastbitcoin_qt test_fastbitcoin_qt
clean: FORCE
        $(MAKE) -C .. fastbitcoin_qt_clean test_fastbitcoin_qt_clean
check: FORCE
        $(MAKE) -C .. test_fastbitcoin_qt_check
fastbitcoin-qt fastbitcoin-qt.exe: FORCE
         $(MAKE) -C .. fastbitcoin_qt
