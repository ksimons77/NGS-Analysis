#!/usr/bin/env bash

# Usage:  /tools/scripts/barcode_splitter.sh /usbdrive/CBBSeq/ks1.2000.fastq /usbdrive/bar-files 0mismatches_unmatchedinput 0 1

# Stop script on NZEC
set -e
# Stop script if unbound variable found (use ${var:-} if intentional)
set -u

# better variable names
# true options w/optional
# fix ""
# output stdout to file

fastq="$1"
barcodes="$2"
outdir="$3"
nummismatches="$4"
uselast="$5"

mkdir -p $outdir

for barcode in `ls $barcodes/* | sort -r`
do
  basebarcodename=$(basename $barcode)
  outname=$(echo $basebarcodename | cut -f 1 -d '.')
  echo "Processing $barcode file..."
  cmd="cat $fastq | /usr/local/bin/fastx_barcode_splitter.pl --bcfile $barcode --bol --mismatches $nummismatches --suffix \".txt\" --prefix $outdir/$outname |& tee -a $outdir/output.txt"
  echo $cmd
  eval $cmd

  if [ $uselast -eq 1 ]
  then
    fastq="$outdir/$outname""unmatched.txt"
  fi
done
