#!/bin/bash
echo "=============================================================================================================="
echo "Please run the script as: "
echo "bash bash run_eval.sh device_id config ckpt_file output_dir nimages"
echo "For example: bash run_eval.sh DEVICE_ID CONFIG_PATH CKPT_FILE_PATH OUTPUT_DIR NIMAGES"
echo "It is better to use the absolute path."
echo "=============================================================================================================="

EXEC_PATH=$(pwd)
echo "$EXEC_PATH"
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

cd ../
rm -rf eval
mkdir eval
cd ./eval
mkdir src
cd ../
cp ./*.py ./eval
cp ./src/*.py ./eval/src
cd ./eval

env > env0.log

echo "train begin."
python eval.py --device_id $1 --config $2 --ckpt_file $3 --output_dir $4 --nimages $5 > ./eval.log 2>&1 &

if [ $? -eq 0 ];then
    echo "eval success"
else
    echo "eval failed"
    exit 2
fi
echo "finish"
cd ../
