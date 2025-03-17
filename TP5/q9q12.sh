#!/bin/bash

GEM5="/home/g/gbusnot/ES201/tools/TP5/gem5-stable"
OUTPUT_DIR="results_A15"
TEST_BINARY="./test_omp"
MATRIX_SIZE=16

mkdir -p $OUTPUT_DIR

THREADS=(1 2 4 8 16)
WIDTHS=(2 4 8)

BASE_TICKS=0

for WIDTH in "${WIDTHS[@]}"; do
    for NTHREADS in "${THREADS[@]}"; do
        echo "Running test with $NTHREADS threads and O3 width $WIDTH..."
        
        $GEM5/build/ARM/gem5.fast \
            $GEM5/configs/example/se.py \
            --cpu-type=detailed \
            --caches \
            --l2cache \
            -n $NTHREADS \
            --o3-width $WIDTH \
            -c $TEST_BINARY \
            -o "$NTHREADS $MATRIX_SIZE" > $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt
        
        mv m5out/stats.txt $OUTPUT_DIR/stats_${NTHREADS}_${WIDTH}.txt 2>/dev/null

        TICKS=$(grep "sim_ticks" $OUTPUT_DIR/stats_${NTHREADS}_${WIDTH}.txt | awk '{print $2}')
        echo "n=$NTHREADS, w=$WIDTH : $TICKS" >> $OUTPUT_DIR/q9.txt

        INSTS=$(grep "sim_insts" $OUTPUT_DIR/stats_${NTHREADS}_${WIDTH}.txt | awk '{print $2}')
        echo "n=$NTHREADS, w=$WIDTH : $INSTS" >> $OUTPUT_DIR/q10.txt

        if [[ -z "$TICKS" || -z "$INSTS" ]]; then
            echo "Error: Missing simulation results for $NTHREADS threads, width $WIDTH." >&2
            continue
        fi

        IPC=$(awk "BEGIN {print $INSTS / $TICKS}")
        echo "$IPC" >> $OUTPUT_DIR/q11.txt

        if [[ $NTHREADS -eq 1 && $WIDTH -eq 2 ]]; then
            BASE_TICKS=$TICKS
            echo "n=$NTHREADS, w=$WIDTH : 1.0" >> $OUTPUT_DIR/q12.txt
        else
            SPEEDUP=$(awk "BEGIN {print $BASE_TICKS / $TICKS}")
            echo "n=$NTHREADS, w=$WIDTH : $SPEEDUP" >> $OUTPUT_DIR/q12.txt
        fi
    done
done

echo "Test finished. Results in $OUTPUT_DIR"
