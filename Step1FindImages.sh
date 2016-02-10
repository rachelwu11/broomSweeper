#!/bin/sh

# use cat.png, cat@2x.png, cat@3x.png, lizard.png, lizard@2x.png, lizard@3x.png as examples
# --> cat.png, lizard.png, and use these to search
# save output to be file.txt

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo $'\xF0\x9F\x90\xA3'"  Current Time : $current_time"

PROJ=`find . -name '*.xib' -o -name '*.[mh]' -o -name '*.storyboard' -o -name '*.mm' -o -name '*.swift' -o -name '*.json'`

#prune will exclude "Image.xcassets" folder and "Hello World" folder
find . \( -name Images.xcassets -o -name libraries -o -name "Hello World" \) -prune -o \( -name "*.png" -o -name "*.gif" -o -name "*.jpg" \) -print0 | while read -d $'\0' image
do
    name="${image##*/}"
    extension="${name##*.}"
    name="${name%.*}"
    
    name=`basename -s @2x $name`
    name=`basename -s @3x $name`
    name="$name.$extension"

    var2=$((var2 + 1))
    echo "images in total: $var2"
    echo $'\xF0\x9F\x90\xA4'"  $name added"

    if ! grep -qhs "$name" $PROJ; then
        var=$((var + 1))
        array[${#array[@]}]=$image
    fi
    #use printf instead of echo, since echo can't support \n to go to newline
    #also, put this line inside for loop, will be easy to check output when running
    printf "%s\n" "${array[@]}" > file.txt
done
echo "counter: $var"


while read line;
do
    if [[ $line == *"@"* ]]; then
        name=`basename "$line"`
        var=$((var + 1))
        echo "image counter: $var"
        
        if grep -qhs "$name" $PROJ; then
            var2=$((var2 + 1))
            array[${#array[@]}]=$line
            echo $'\xF0\x9F\x90\xA5'"  $line"
            printf "%s\n" "${array[@]}" > file2.txt

        fi
    fi
done < file.txt

echo "counter: $var2"

awk 'NR==FNR{a[$0];next} !($0 in a)' file2.txt file.txt > file3.txt

current_time2=$(date "+%Y.%m.%d-%H.%M.%S")
echo $'\xF0\x9F\x90\xA3'"  Current Time : $current_time2"