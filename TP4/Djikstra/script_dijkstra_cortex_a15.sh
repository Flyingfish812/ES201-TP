#!/bin/bash

SIM_OUT_ORDER=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder

mkdir -p Cortex_A15

for SIZE in small large
do
	PRG_SS="dijkstra_${SIZE}.ss input.dat"
	for NSETS in 16 32 64 128 256
	do
	REDIR_OUT_SIMU="-redir:sim Cortex_A15/dijkstra_${SIZE}_NSETS_${NSETS}"
	OPTIONS="-fetch:ifqsize 8 -decode:width 4 -issue:width 8 -issue:inorder false -commit:width 4 -ruu:size 16 -lsq:size 16 -res:memport 2"
	UNIT_FONCT="-res:ialu 5 -res:imult 1 -res:fpalu 1 -res:fpmult 1"
	BRANCH_PRED="-bpred 2lev -bpred:btb 256 4"
	CACHE="-cache:dl1 dl1:${NSETS}:64:2:l -cache:il1 il1:${NSETS}:64:2:l -cache:dl2 dl2:512:64:16:l -cache:il2 il2:512:64:16:l"
	echo "$SIZE ${NSETS}"
	$SIM_OUT_ORDER $OPTIONS $UNIT_FONCT $BRANCH_PRED $CACHE $REDIR_OUT_SIMU $PRG_SS
	done
done



