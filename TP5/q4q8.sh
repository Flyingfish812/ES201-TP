#!/bin/bash

GEM5="/home/g/gbusnot/ES201/tools/TP5/gem5-stable"
OUTPUT_DIR="results"
TEST_BINARY="./test_omp"
MATRIX_SIZE=16

THREADS=(1 2 4 8 16)

mkdir -p $OUTPUT_DIR

BASE_TICKS=0

for NTHREADS in "${THREADS[@]}"; do
    echo "Running test with $NTHREADS threads..."

    $GEM5/build/ARM/gem5.fast \
        $GEM5/configs/example/se.py \
        --cpu-type=arm_detailed \
        --caches \
        --l2cache \
        -n $NTHREADS \
        -c $TEST_BINARY \
        -o "$NTHREADS $MATRIX_SIZE" > $OUTPUT_DIR/output_${NTHREADS}threads.txt

    mv m5out/stats.txt $OUTPUT_DIR/stats_${NTHREADS}.txt 2>/dev/null

    TICKS=$(grep "sim_ticks" $OUTPUT_DIR/stats_${NTHREADS}.txt | awk '{print $2}')
    echo "n=$NTHREADS : $TICKS" >> $OUTPUT_DIR/q4.txt

    INSTS=$(grep "sim_insts" $OUTPUT_DIR/stats_${NTHREADS}.txt | awk '{print $2}')
    echo "n=$NTHREADS : $INSTS" >> $OUTPUT_DIR/q5.txt

    if [[ -z "$TICKS" || -z "$INSTS" ]]; then
        echo "Error: Missing simulation results for $NTHREADS threads." >&2
        continue
    fi

    IPC=$(awk "BEGIN {print $INSTS / $TICKS}")
    echo "$IPC" >> $OUTPUT_DIR/q7.txt

    if [ "$NTHREADS" -eq 1 ]; then
        BASE_TICKS=$TICKS
        echo "n=$NTHREADS : 1.0" >> $OUTPUT_DIR/q6.txt
    else
        SPEEDUP=$(awk "BEGIN {print $BASE_TICKS / $TICKS}")
        echo "n=$NTHREADS : $SPEEDUP" >> $OUTPUT_DIR/q6.txt
    fi
done

echo "Test finished. Results in $OUTPUT_DIR"
