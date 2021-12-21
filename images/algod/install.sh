#!/usr/bin/env bash

# Script to install algod in all sorts of different ways.
#
# Parameters:
#    -d    : Location where binaries will be installed.
#    -c    : Channel to install. Mutually exclusive with source options.

set -e

rootdir=`dirname $0`
pushd $rootdir

BINDIR=""
CHANNEL=""

while getopts "d:c:" opt; do
  case "$opt" in
    d) BINDIR=$OPTARG; ;;
    c) CHANNEL=$OPTARG; ;;
  esac
done

if [ -z BINDIR ]; then
  echo "-d <bindir> is required."
  exit 1
fi


echo "Installing algod with options:"
echo "  BINDIR = ${BINDIR}"
echo "  CHANNEL = ${CHANNEL}"

if [ ! -z $CHANNEL ]; then
  ./update.sh -i -c $CHANNEL -p $BINDIR -d $BINDIR/data -n
  exit 0
fi

$BINDIR/algod -v
