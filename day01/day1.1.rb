#! /usr/bin/env ruby -an

BEGIN {$sum=0}
END {puts "Calibration value: #{$sum}"}

$first = $_.match(/[^0-9]*([0-9]).*$/)[1]
$last  = $_.match(/.*([0-9])[^0-9]*$/)[1]

$sum += ($first+$last).to_i