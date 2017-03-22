#!/usr/bin/env bash

# Stop script on NZEC
set -e
# Stop script if unbound variable found (use ${var:-} if intentional)
set -u

execute()
{
    echo "Executing: $@"
    if [ $dryRun -eq 0 ]; then
        "$@ |& tee -a $outputDir/output$suffix";
    fi
}

say_err() {
    printf "%b\n" "Error: $1" >&2
}

showHelp() {
    echo "Usage: $0 [OPTIONS] FASTQ BARCODES"
    echo
    echo "Invokes the fastx_barcode_splitter tool on the specified fastqc file for the specified barcodes"
    echo
    echo "FASTQ                 The fastq input file"
    echo "BARCODES              The directory that contains the files listing the barcodes to split on"
    echo
    echo "Options:"
    echo "      --dryRun        Perform a dry run emitting the commands that would be invoked"
    echo "  -h, --help          Show the help"
    echo "  -m, --mismatches    The number of mismatches allowed"
    echo "  -o, --output        The directory to write the output to"
    echo "  -s, --suffix        The suffix of the output files"
    echo "      --unmatched     Whether or not to run the subsequent splits on the unmatched results"
}

barcodes=
dryRun=0
fastqInput=
mismatches=0
outputDir="barcode_splitter_results"
splitterPath="/usr/local/bin/fastx_barcode_splitter.pl"
suffix=".txt"
useUnmatched=0

if [ $# -eq 0 ]; then
    showHelp            
    exit 1
fi

while [ $# -ne 0 ]; do
    name=$1
    case $name in  
        --dryRun)
            dryRun=1
            ;;
        -h|--help)
            showHelp
            exit 0
            ;;
        -m|--mismatches)
            shift
            mismatches=$1
            ;;
        -o|--output)
            shift
            outputDir="$1"
            ;;
        -s|--suffix)
            shift
            suffix="$1"
            ;;
        -u|--unmatched)
            useUnmatched=1
            ;;
        -*)
            say_err "Unknown option: $1"
            showHelp            
            exit 1
            ;;
        *)
            if [ ! -z "$fastqInput" ]; then
                if [ ! -z "$barcodes" ]; then
                    say_err "Unknown argument: \`$name\`"
                    exit 1
                fi

                barcodes="$1"
            else
                fastqInput="$1"
            fi

            ;;
    esac

    shift
done

if [ -z "$fastqInput" ]; then
    say_err "fastqInput not specified"
    showHelp            
    exit 1
fi

if [ -z "$barcodes" ]; then
    say_err "barcodes not specified"
    showHelp            
    exit 1
fi

if [ $dryRun -eq 0 ]; then
    mkdir -p $outputDir
fi

for barcode in `ls $barcodes/* | sort -r`; do
    barcodeBasename=$(basename $barcode)
    outputFile=$(echo $barcodeBasename | cut -f 1 -d '.')
    prefix="$outputDir/$outputFile"

    echo "Processing $barcode file..."
    cmd="cat $fastqInput | $splitterPath --bcfile $barcode --bol --mismatches $mismatches --suffix \"$suffix\" --prefix $prefix"
    execute eval $cmd

    unmatchedFile="${prefix}unmatched${suffix}"
    if [ $useUnmatched -eq 1 ]; then
        fastqInput="$unmatchedFile"
    else
        execute rm $unmatchedFile
    fi
done
