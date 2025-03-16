#!/bin/bash

GEM5="/home/g/gbusnot/ES201/tools/TP5/gem5-stable"

OUTPUT_DIR="results"
mkdir -p $OUTPUT_DIR

Q2FILE="$OUTPUT_DIR/q2.txt"
Q3FILE="$OUTPUT_DIR/q3.txt"

grep "Param" $GEM5/src/cpu/o3/O3CPU.py >> $Q2FILE
grep "parser.add_option" $GEM5/configs/common/Options.py >> $Q3FILE
