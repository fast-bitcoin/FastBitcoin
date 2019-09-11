#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

FASTBITCOIND=${FASTBITCOIND:-$SRCDIR/fastbitcoind}
FASTBITCOINCLI=${FASTBITCOINCLI:-$SRCDIR/fastbitcoin-cli}
FASTBITCOINTX=${FASTBITCOINTX:-$SRCDIR/fastbitcoin-tx}
FASTBITCOINQT=${FASTBITCOINQT:-$SRCDIR/qt/fastbitcoin-qt}

[ ! -x $FASTBITCOIND ] && echo "$FASTBITCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BSDVER=($($FASTBITCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for fastbitcoind if --version-string is not set,
# but has different outcomes for fastbitcoin-qt and fastbitcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$FASTBITCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $FASTBITCOIND $FASTBITCOINCLI $FASTBITCOINTX $FASTBITCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BSDVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BSDVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
