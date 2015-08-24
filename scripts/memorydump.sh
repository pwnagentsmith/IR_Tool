#!/bin/bash

BASE_DIR='memory'

# check gdb exists or not
gdblocation=`command -v gdb`
if [[ -z "$gdblocation" ]]; then
	echo "gdb is not exists!\n Memory Dump fails!!\n"
	exit 1
fi
mkdir -p $BASE_DIR

# dump memory by gdb batch script
pids=`ps aux| grep -v PID |awk '{print $2}'`
for i in $pids; do
	echo "dumping PID: $i"
	mkdir -p $BASE_DIR/$i
	grep rw-p /proc/$i/maps | sed -n 's/^\([0-9a-f]*\)-\([0-9a-f]*\) .*$/\1 \2/p' | while read start stop; do gdb --batch --pid $i -ex "dump memory $BASE_DIR/$i/$i-$start-$stop 0x$start 0x$stop"; done
	echo "dumped PID: $i"
done
echo "DONE"
