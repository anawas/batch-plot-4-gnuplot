#!/bin/bash
readonly DIRECTION=left
for DATAFILENAME in $(ls -1 final_translations_"$DIRECTION"_*.csv)
do
  echo $DATAFILENAME
  NAME=$(echo $DATAFILENAME | cut -d_ -f 4- -s | cut -d. -f 1)
  FILENAME=plot_$NAME.gpl
  cp plot-template.gpl temp.gpl
  NUMBER=$(echo $NAME | sed -e "s/[^0-9]//g")
  sed  -e "s/%OUTNAME%/${NAME}/" \
       -e "s/%FILENAME%/${DATAFILENAME}/g" \
       -e "s/%TITLE%/${NAME}: ${DIRECTION}/g" <temp.gpl >$FILENAME
  mv $FILENAME ./batchjobs
done

cd ./batchjobs
for NAME in $(ls -1 *.gpl)
do
  sed "s/%OUTNAME%/${NAME}/" $NAME > temp1.gpl
  gnuplot temp1.gpl
done
