#!/bin/sh
start=`date +%s`
( 
  for a in `grep ::Action:: BuildList | awk -F '::' '{print \$5}'`; do (
    echo $a
    P6_AWS_TESTING=1 perl6 -Ilib t/04-actions.t --unit=$a --tests=basic 2>&1
  )
  done;
) 2>&1 | tee -a LastActionTests
end=`date +%s`
runtime=$((end-start))
echo "Tests ran in $runtime seconds";
grep nok LastActionTests
