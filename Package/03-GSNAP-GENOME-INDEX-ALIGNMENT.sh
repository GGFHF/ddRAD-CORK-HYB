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

# This script performs Q. suber genome indexing and read alignment with gmap/gsnap (Andrews 2010)

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

GSNAP_DIR=PATH_TO_GSNAP_BINARIES
GENOME_DIR=PATH_TO_YOUR_GENOME_DIRECTORY/genome			#where Q. suber genomic assembly files are stored
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY				#where your filtered read files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY
cd $GSNAP_DIR

#-------------------------------------------------------------------------------
# Execute the program gmap_build

echo '**************************************************'
echo 'GMAP_BUILD IS BUILDING THE QUERCUS SUBER GENOME DATABASE...'
    
    $GSNAP_DIR/gmap_build -d $GENOME_DIR -C $GENOME_DIR/GCF_002906115.1_CorkOak1.0_genomic.fna.gz -g
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

# Execute the program gsnap

echo '**************************************************'
echo 'GSNAP IS RUNNING ...'

ls $DATA_DIR/*.gz > $DATA_DIR/filtered-read-files.txt

while read FILE; do

    SPLIT=`echo $FILE | sed 's/.fastq.gz/-output/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    FAILED=`echo $FILE | sed 's/.fastq.gz/-failed/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    $GMAPDIR/gsnap --gunzip \
    --dir=$GENOMEDIR \
    --db=genome \
    --force-single-end \
    --quality-protocol=sanger \
    --format=sam \
    --split-output=$SPLIT \
    --failed-input=$FAILED \
    --nthreads=8 \
    $FILE
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

done < $DATA_DIR/filtered-read-files.txt


rm $DATA_DIR/filtered-read-files.txt
#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
