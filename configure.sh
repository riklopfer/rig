#!/usr/bin/env bash
LOC=$(dirname $(readlink -f $0))

echo
echo "Running shared configuration"
echo
$LOC/link_configs.sh $LOC/shared/configs
$LOC/shared/configure.sh

if ! source /etc/os-release 2> /dev/null; then
    echo "Cannot find /etc/os-release -- don't know how to proceed."
    exit 1
fi

if ! [ -d $LOC/$ID ]; then 
    echo "No configurations for OS: $ID"
    exit 1
fi

echo 
echo "Running $ID configuration"
echo 
[ -d $LOC/$ID/configs ] && $LOC/link_configs.sh $LOC/$ID/configs
[ -f $LOC/$ID/configure.sh ] && $LOC/$ID/configure.sh