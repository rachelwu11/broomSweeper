#!/bin/sh

#scan the whole project, to check the spots where we use images but don't have extension
#eg. [UIImage imageNamed:@"hello_world.png"]
#eg. [UIImage iamgeNamed:@"hello_world"]		//print this line

#Objective-C
grep -r --include=*.m '^.*imageNamed:.*$' . | grep -v '^.*png.*$' > output01.txt


#swift
grep -r --include=*.swift '^.*UIImage(named:.*$' . | grep -v  '^.*png.*$' > output02.txt