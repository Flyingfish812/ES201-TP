#!/bin/bash

# 定义输出目录和结果文件
OUTPUT_DIR="sim_results"
SUMMARY_FILE="summary_results.csv"

# 创建汇总文件并写入表头
echo "L1 Size (KB),IPC,il1.miss_rate,dl1.miss_rate,ul2.miss_rate" > $SUMMARY_FILE

# 遍历所有模拟结果文件
for FILE in $OUTPUT_DIR/*.txt; do
    # 从文件名中提取L1缓存大小
    L1_SIZE=$(basename $FILE | grep -oP '(?<=L1_)\d+(?=KB)')

    # 从文件中提取所需数据
    IPC=$(grep "sim_IPC" $FILE | awk '{print $2}')
    IL1_MISS_RATE=$(grep "il1.miss_rate" $FILE | awk '{print $2}')
    DL1_MISS_RATE=$(grep "dl1.miss_rate" $FILE | awk '{print $2}')
    UL2_MISS_RATE=$(grep "ul2.miss_rate" $FILE | awk '{print $2}')

    # 将提取的数据写入汇总文件
    echo "$L1_SIZE,$IPC,$IL1_MISS_RATE,$DL1_MISS_RATE,$UL2_MISS_RATE" >> $SUMMARY_FILE
done

echo "Data extraction completed. Summary results saved to $SUMMARY_FILE."