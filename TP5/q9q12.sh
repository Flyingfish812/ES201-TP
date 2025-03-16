#!/bin/bash

GEM5="/home/g/gbusnot/ES201/tools/TP5/gem5-stable"
OUTPUT_DIR="results"
TEST_BINARY="test_omp"
MATRIX_SIZE=128

mkdir -p $OUTPUT_DIR

THREADS=(1 2 4 8 16)
WIDTHS=(2 4 8)

for WIDTH in "${WIDTHS[@]}"; do
    for NTHREADS in "${THREADS[@]}"; do
        echo "Running test with $NTHREADS threads and issue width $WIDTH..."
        
        $GEM5/build/ARM/gem5.fast \
            $GEM5/configs/example/se.py \
            --cpu-type=detailed \
            --caches \
            --l2cache \
            -n $NTHREADS \
            --width $WIDTH \
            -c $TEST_BINARY \
            -o "$NTHREADS $MATRIX_SIZE" > $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt

        grep "sim_ticks" $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt | awk '{print $2}' >> $OUTPUT_DIR/q9.txt

        grep "sim_insts" $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt | awk '{print $2}' >> $OUTPUT_DIR/q10.txt

        INSTS=$(grep "sim_insts" $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt | awk '{print $2}')
        TICKS=$(grep "sim_ticks" $OUTPUT_DIR/output_${NTHREADS}threads_${WIDTH}width.txt | awk '{print $2}')
        IPC=$(awk "BEGIN {print $INSTS / $TICKS}")
        echo "$IPC" >> $OUTPUT_DIR/q11.txt

        if [[ $NTHREADS -eq 1 && $WIDTH -eq 2 ]]; then
            BASE_TICKS=$TICKS
            echo "1.0" >> $OUTPUT_DIR/q12.txt
        else
            SPEEDUP=$(awk "BEGIN {print $BASE_TICKS / $TICKS}")
            echo "$SPEEDUP" >> $OUTPUT_DIR/q12.txt
        fi
    done
done

echo "Test finished. Results in $OUTPUT_DIR"
