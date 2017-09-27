#!/bin/bash
# Usage: $0 <files to check>
# Run shellcheck with the output in the GCC format
# Consider each file one test
# Warnings/errors -> test fails, print all messages under "not ok"
# No diagnostics, or notes only -> test passes
runShellcheckOnFiles(){
	shellcheckExecutable=$1
	shift
	echo 1..$#
	num=1
	for file in "$@" ; do
IFS="
"
		msgs="$("$shellcheckExecutable" -f gcc "$file")"
		if grep -q 'warning\|error' <<< $msgs ; then
			echo not ok "$num" - "$file"
			for line in $msgs ; do
				echo "#" $line
			done
		else
			echo ok "$num" - "$file"
		fi
		num=$((num+1))
	 done
}


[[ "$0" == "${BASH_SOURCE[0]}" ]] && runShellcheckOnFiles "$(which shellcheck)" "$@"
