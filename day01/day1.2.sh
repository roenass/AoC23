#!/bin/sh
sed -E  -e 's/one/o1e/g'  -e 's/two/t2o/g'  -e 's/three/t3e/g'  \
        -e 's/four/f4r/g' -e 's/five/f5e/g' -e 's/six/s6x/g'    \
        -e 's/seven/s7n/g' -e 's/eight/e8t/g' -e 's/nine/n9n/g' |
    $(dirname $0)/day1.1.sh
