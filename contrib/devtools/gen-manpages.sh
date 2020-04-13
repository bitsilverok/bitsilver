#!/usr/bin/env bash
# Copyright (c) 2016-2019 The BitSilver Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITSILVERD=${BITSILVERD:-$BINDIR/bitsilverd}
BITSILVERCLI=${BITSILVERCLI:-$BINDIR/bitsilver-cli}
BITSILVERTX=${BITSILVERTX:-$BINDIR/bitsilver-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/bitsilver-wallet}
BITSILVERQT=${BITSILVERQT:-$BINDIR/qt/bitsilver-qt}

[ ! -x $BITSILVERD ] && echo "$BITSILVERD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BTRVER <<< "$($BITSILVERCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for bitsilverd if --version-string is not set,
# but has different outcomes for bitsilver-qt and bitsilver-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITSILVERD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITSILVERD $BITSILVERCLI $BITSILVERTX $WALLET_TOOL $BITSILVERQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTRVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTRVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
