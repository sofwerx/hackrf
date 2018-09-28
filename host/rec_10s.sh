#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

while true; do
  frequency=$(hackrf_sweep -1 -f1:7250 -w 100000 -l32 -g8 2>/dev/null | grep 2018 | ./hackrf_sweep_sorter.pl | head -1 | awk '{print $3}' | cut -d. -f1) 
  capturefile=./captures/$(date +%Y%m%d%H%M%S)_${frequency}
  echo "Capturing 1mhz bandwidth for 10 seconds at ${frequency} to ${capturefile}"
  hackrf_transfer -s 2000000 -f ${frequency} -r ${capturefile} -n 20000000
  gzip -v $capturefile
done
