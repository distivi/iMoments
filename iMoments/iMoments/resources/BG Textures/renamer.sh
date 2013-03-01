#!/bin/bash
ls | grep _@2X | while read line;
do	
	fileName=$(echo $line | sed -E "s/(.*)@2x.png/\1/")@2x.png
	echo rename $line to $fileName
	mv $line $fileName
done
