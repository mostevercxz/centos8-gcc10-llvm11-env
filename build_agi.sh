#!/bin/bash

set -e
AGI_FOLDER_NAME=weihao_agi
mkdir -p $AGI_FOLDER_NAME
mkdir -p $AGI_FOLDER_NAME/logs
docker cp giantdev:/home/dev/work/project_zero/server/build/agi_server/AgiServer $AGI_FOLDER_NAME/
docker cp giantdev:/home/dev/work/project_zero/server/build/config.xml $AGI_FOLDER_NAME/
# 这里agi配置能直接用,原因是docker的网卡会新分配一个网址
#docker cp giantdev:/home/dev/work/project_zero/server/build/agi_config.xml $AGI_FOLDER_NAME/
sed -i 's#/home/dev/log/agiserver.log#/root/logs/agiserver.log#' $AGI_FOLDER_NAME/agi_config.xml
rm -rf $AGI_FOLDER_NAME/script
docker cp giantdev:/home/dev/work/project_zero/ServerRes/script $AGI_FOLDER_NAME/
rm -rf $AGI_FOLDER_NAME/gdd_xls
docker cp giantdev:/home/dev/work/project_zero/server/build/gdd_xls $AGI_FOLDER_NAME/
rm -rf $AGI_FOLDER_NAME/jsonconfig
rm -rf $AGI_FOLDER_NAME/gdd_json
docker cp giantdev:/home/dev/work/project_zero/ServerRes/jsonconfig $AGI_FOLDER_NAME/
mv $AGI_FOLDER_NAME/jsonconfig $AGI_FOLDER_NAME/gdd_json
docker build --build-arg AGI_FOLDER=$AGI_FOLDER_NAME --progress=plain -t agidev:latest . -f ./Dockerfile.agi
