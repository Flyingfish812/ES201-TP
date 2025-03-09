#!/bin/bash

SIM_OUTORDER="/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder"
PRG_SS="prodmatrix.ss"

L1_SIZES=(1 2 4 8 16)

OUTPUT_DIR="sim_results"
mkdir -p $OUTPUT_DIR

for L1_SIZE in "${L1_SIZES[@]}"; do
    IL1_SIZE="${L1_SIZE}k"
    DL1_SIZE="${L1_SIZE}k"

    UL2_SIZE="512k"

    OUTPUT_FILE="${OUTPUT_DIR}/sim_results_L1_${L1_SIZE}KB.txt"

    $SIM_OUTORDER \
        -cache:il1 il1:$((L1_SIZE * 1024 / 32)):32:1:l \
        -cache:dl1 dl1:$((L1_SIZE * 1024 / 32)):32:1:l \
        -cache:il2 dl2 \
        -cache:dl2 ul2:1024:64:4:l \
        -redir:sim $OUTPUT_FILE \
        $PRG_SS

    echo "Simulation for L1 size ${L1_SIZE}KB completed. Results saved to $OUTPUT_FILE"
done

echo "All simulations completed. Results are stored in the $OUTPUT_DIR directory."