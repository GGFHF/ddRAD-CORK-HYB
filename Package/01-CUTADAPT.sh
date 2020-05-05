#!/bin/bash

#-------------------------------------------------------------------------------

# This software has been developed by:
#
#    GI Sistemas Naturales e Historia Forestal (formerly known as GI Genetica, Fisiologia e Historia Forestal)
#    Dpto. Sistemas y Recursos Naturales
#    ETSI Montes, Forestal y del Medio Natural
#    Universidad Politecnica de Madrid
#    https://github.com/ggfhf/
#
# Licence: GNU General Public Licence Version 3.

#-------------------------------------------------------------------------------

# This script performs raw read filtering and pre-processing with cutadapt (Martin 2011).

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

CUTADAPT_DIR=PATH_TO_CUTADAPT_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY			#where your raw read files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

cd $CUTADAPT_DIR

#-------------------------------------------------------------------------------

# Execute the program cutadapt
echo '**************************************************'
echo 'CUTADAPT IS RUNNING ...'

ls $DATA_DIR/*.gz > $DATA_DIR/raw-read-files.txt

while read FILE; do
    FILTERED_FILE=`echo $FILE | sed 's/.fastq.gz/trimmed.fastq.gz/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    $CUTADAPT_DIR/cutadapt \
        -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
        -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
        -m 20 \
        -q 20 \
        --max-n 0.1 \
        -o $FILTERED_FILE \
        $FILE
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
done < $DATA_DIR/raw-read-files.txt


rm $DATA_DIR/raw-read-files.txt
#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
