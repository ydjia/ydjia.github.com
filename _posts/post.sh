#!/bin/sh

while getopts "am" arg
do
	case $arg in
		a)
			git add .&&git commit -m "new post"&&git push
			exit 1
			;;
		m)
			git add .&&git commit -m "modify post"&&git push
			exit 1
			;;
		?)
			echo "use -a or -m"
	esac
done

