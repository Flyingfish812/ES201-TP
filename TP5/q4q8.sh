#!/bin/bash

GEM5="/home/g/gbusnot/ES201/tools/TP5/gem5-stable"
OUTPUT_DIR="results"
TEST_BINARY="test_omp"
MATRIX_SIZE=128

mkdir -p $OUTPUT_DIR

THREADS=(1 2 4 8 16)

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
    
    grep "sim_ticks" $OUTPUT_DIR/output_${NTHREADS}threads.txt | awk '{print $2}' >> $OUTPUT_DIR/q4.txt
    
    grep "sim_insts" $OUTPUT_DIR/output_${NTHREADS}threads.txt | awk '{print $2}' >> $OUTPUT_DIR/q5.txt
    
    INSTS=$(grep "sim_insts" $OUTPUT_DIR/output_${NTHREADS}threads.txt | awk '{print $2}')
    TICKS=$(grep "sim_ticks" $OUTPUT_DIR/output_${NTHREADS}threads.txt | awk '{print $2}')
    IPC=$(awk "BEGIN {print $INSTS / $TICKS}")
    echo "$IPC" >> $OUTPUT_DIR/q7.txt

    if [ $NTHREADS -eq 1 ]; then
        BASE_TICKS=$TICKS
        echo "1.0" >> $OUTPUT_DIR/q6.txt
    else
        SPEEDUP=$(awk "BEGIN {print $BASE_TICKS / $TICKS}")
        echo "$SPEEDUP" >> $OUTPUT_DIR/q6.txt
    fi
done

echo "Test finished. Results in $OUTPUT_DIR"
