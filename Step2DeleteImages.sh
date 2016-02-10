#!/bin/sh

lineNum=`cat file3.txt | wc -l`
echo $'\xF0\x9F\x90\xA3'  $'\xF0\x9F\x90\xA3'  $'\xF0\x9F\x90\xA3'

# back up project.pbxproj inside Temp folder, don't forget to delete this folder later!
#use replaceWithYourProjectName.xcodeproj as an example
d='Temp'
test -d "$d" || mkdir -p "$d" && cp replaceWithYourProjectName.xcodeproj/project.pbxproj "$d/project.pbxproj"


while read line;
do
    name="${line##*/}"
    # in project.pbxproj, the string format looks like "/* BU.png ""
    name="\/* $name "

    var=$((var + 1))
    echo "Progress:" $var/$lineNum

    sed -n -e "/$name/d" replaceWithYourProjectName.xcodeproj/project.pbxproj
	
	#if git, then just use: git rm -f "$line"
    if [[ $line == *"@"* ]]; then
		svn delete "$line@"
	else

		svn delete "$line"
	fi

done < file3.txt

echo $'\xF0\x9F\x90\xA3'  $'\xF0\x9F\x90\xA3'  $'\xF0\x9F\x90\xA3'  "Thank you^^"
