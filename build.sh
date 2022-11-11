buildId=$1
echo "Build Request Id: $1" > "$buildId.log"
cd cicd
bassh ./build-app.sh "$buildId.json" "$buildId.log"
echo "put $buildId.json $buildId.json" > "sftp.$buildId.upload"
sftp -b "sftp.$buildId.upload" rzmudzin@192.168.64.15
ssh rzmudzin@192.168.64.15 ./build.sh "$buildId"
