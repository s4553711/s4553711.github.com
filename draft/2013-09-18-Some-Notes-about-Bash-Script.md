---
layout: post
title: Some Notes about Bash Script
date: 2013-09-18 16:26:51
categories:
	- bash
---
Here are some functions of bash that I use in current job. It is very important to take advantage of the convenience of bash script to achieve some jobs in efficient way.
#### if/else
``` bash
if [[ confition ]];
then
	date
else
	date
fi
```

#### Parse file content
``` bash
IFS=$'\n'
FILENAME=$1
while read line
do
	echo $line
done < $FILENAME
```

#### Read return info from process
``` bash
IFS=$'\n'
RESULT=$(/path/script.sh)

for tmp_line in $RESULT
do
	echo $tmp_line
done

```

#### Grep
``` bash
grep -c '^info' # find the counts of match
grep -v '^info' # inverse-match
```

#### build variable names from other variables in bash
``` bash
FLAG1="Text1"
FLAG2="Text2"
FLAG3="Text3"
FLAG4="Text4"
for t in {1..4}
do
	TEST_SET="FLAG"${t}
	echo ${!TEST_SET}
done
```

#### For loop
``` bash
for ((i=$1; i<=$2; i++)) do
	echo $Variables
done
```

#### Add 1 to a variable
``` bash
Error_SIG=1
Error_SIG=$(( $Error_SIG + 1 ))
echo $Error_SIG		# echo 2
```

#### Color output
``` bash
printf "\e[32mPass\e[0m\n"
echo -e "\e[32mPass\e[0m\n"
```
