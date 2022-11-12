#!/bin/zsh
buildId=$1
log="$(pwd)/$2"
echo "Starting Build Process using build file $buildId.json" >> $log
echo "${BASH_VERSION}" >> $log
git --version

data=$(python3 json-parse.py "$buildId.json")
echo $data


parts=("${(f)data}")
# echo $parts
# echo ${#parts[@]}
len=${#parts[@]}
echo "Build Data Count: $len" >> $log

declare -A buildArgs

echo "Extracted Build Values..." >> $log
name=""
value=""
COUNTER=0
while [  $COUNTER -lt $len ]; do
    echo ${parts[$COUNTER]} >> $log
    if [ -z "${name}" ]; then
        name=${parts[$COUNTER]}
    else 
        buildArgs[$name]=${parts[$COUNTER]}
        name=""
    fi    
    let COUNTER=COUNTER+1 
done
echo "$COUNTER Build Values Extracted" >> $log

echo  "Build Parameters..." >> $log
for key value in ${(kv)buildArgs}; do
    # echo "$key -> $value"
    echo "$key $buildArgs[$key]" >> $log
done


repoUrl=$buildArgs["GIT_REPO_URL"]
repoUrl=$(echo "$repoUrl" | sed -e 's|git://|git@|g')
repoUrl=$(echo "$repoUrl" | sed -e 's|com/|com:|g')
repoUrl=$(echo "$repoUrl" | sed -e 's|"||')
repoUrl=$(echo "$repoUrl" | sed -e 's|"||')
echo "Cloning repo at " $repoUrl >> $log

mkdir -p "builds/$buildId"
cd "builds/$buildId"
echo "git clone $repoUrl"
git clone $repoUrl
# git --version


# "commit" "Test123"
# "GIT_REPO_URL" "git://github.com/rzmudzin/guesstheflag_uikit.git"
# "GIT_REF_BRANCH" "main"
# "GIT_REF" "refs/heads/main"
# "GIT_BASE_REF" ""
# "GIT_HEAD_REF" ""

echo "Build Completed" >> $log
