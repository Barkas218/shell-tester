#!/bin/bash
#
# simple test with ls to check if the shell can find ls in the PATH

command="env"
tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"

# create a pseudo random file
touch $tmp_file
# send commands
echo "$command" | $SHELL > $tmp_file 2> /dev/null &
echo "$command" | $TSHELL > $tmp_file2 2> /dev/null &

# removes the path differences to compare correctly

sed -i '/^_=|SHLVL/d' $tmp_file > tmp
sed -i '/^_=|SHLVL/d' $tmp_file2 > tmp2

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
if diff <(sort "tmp") <(sort "tmp2"); then
	   print_ok
	   TESTS_PASSED=$((TESTS_PASSED + 1))
	   
else
	   print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))
	   
	   if [[ $SHOWERRORS -eq 1 ]]; then
	   	echo ""
	   	echo -e "[\033[31m************************\033[37m]"
	   	echo ">> Real output << "
	   	cat $tmp_file
	   	echo ">>**************<<"
	   	echo ""
	   	echo "> Expected output: "
	   	echo ""
	   	cat $tmp_file2
	   	echo ">>**************<<"
	    echo -e "[\033[31m************************\033[37m]"
	   fi
fi

# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2
rm -rf tmp
rm -rf tmp2