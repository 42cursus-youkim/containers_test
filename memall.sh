#!/usr/bin/env bash

do_test () {
	# 1=container_name
	test_files=$(find "srcs/${1}" -type f -name '*.cpp' | sort)

  parallel --halt 1 --joblog ${1}.log ./mem ::: "${test_files[@]}"
  result=$?
  rm *.out
	echo "$1 result: [$result]"
  # for file in ${test_files[@]}; do
  #   echo $file!
	# 	./mem "${file}"
  #   echo $?
	# done
	# wait
}

main () {
	containers=(vector map stack set)
	# containers=(vector list map stack queue deque multimap set multiset)
	if [ $# -ne 0 ]; then
		containers=($@);
	fi

	for container in ${containers[@]}; do
		do_test $container 2>/dev/null
	done
}

main $@
