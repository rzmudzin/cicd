log=$2
echo "Starting Build Process using build file $1" >> $2

data=$(python3 json-parse.py "$1")
echo $data >> $2

declare -A buildArgs

parts=($(echo $data | tr "" "\n"))
len=${#parts[@]}
echo "Len: $len" >> $2

echo "Indvidual Values..." >> $2
name=""
value=""
COUNTER=0
while [  $COUNTER -lt $len ]; do
    echo ${parts[$COUNTER]} >> $2
    if [ -z "${name}" ]; then
        name=${parts[$COUNTER]}
    else 
        buildArgs[$name]=${parts[$COUNTER]}
        name=""
    fi    
    let COUNTER=COUNTER+1 
done

echo  "Key Value Pairs..." >> $2
for key in "${!buildArgs[@]}"; do
    echo "$key ${buildArgs[$key]}" >> $2
done

echo "Build Completed" >> $2
