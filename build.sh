#!/bin/zsh

buildId=$1
cd cicd
./build-app.sh "$buildId" "$buildId.log"
echo "put $buildId.json $buildId.json" > "sftp.$buildId.upload"
sftp -b "sftp.$buildId.upload" rzmudzin@192.168.64.15
ssh rzmudzin@192.168.64.15 ./build.sh "$buildId"
