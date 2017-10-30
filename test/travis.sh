#!/usr/bin/env bash
set -ve

echo $RESOLVER

${do_build} || exit 1

export PATH=$PWD:$PATH
export STACK_NB_DIR=$PWD

do_test_1() {

    stack notebook echo Check installation successful
    kernel=$(stack notebook bash -c "echo \$STACK_NOTEBOOK_KERNEL") && echo ${kernel}
    stack notebook jupyter nbconvert --debug --ExecutePreprocessor.kernel_name=${kernel} --to notebook --execute --stdout ${STACK_NB_DIR}/test/DisplayTest.ipynb > test.ipynb
    diff test.ipynb ${STACK_NB_DIR}/test/DisplayTest.ipynb

}

do_test_suite() {
    do_test_1

}

# test within global project
# do_test_suite

# test within a specific project
stack new test-proj $RESOLVER
cd test-proj
do_test_suite
