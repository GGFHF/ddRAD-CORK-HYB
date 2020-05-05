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

# This script merges all individuals vcf files obtained from the alignment to Q. suber reference genomes

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

BCFTOOLS_DIR=PATH_TO_BCFTOOLS_BINARIES
TABIX_DIR=PATH_TO_BCFTOOLS_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY				#where vcf files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

#-------------------------------------------------------------------------------                     
# Compress vcf files with bgzip from tabix (run sudo apt-get install tabix or install from source)

#echo '**************************************************'
#echo 'COMPRESSING VCF FILES WITH BGZIP ...'

ls $DATA_DIR/*.vcf > $DATA_DIR/vcf_files.txt

while read FILE; do

    $TABIX/bgzip $FILE
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
done < $DATA_DIR/vcf_files.txt

# Index vcf.gz files with  tabix (to run multiple files use parallel -sudo apt install parallel)


echo '**************************************************'
echo 'RUNNING TABIX TO INDEX VCF.GZ FILES...'

    parallel $TABIX/tabix -p vcf ::: *vcf.gz 
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

# Running the merge utility from bcftools

echo '**************************************************'
echo 'RUNNING BCFTOOLS TO MERGE VCF.GZ FILES...'

    $BCFTOOLS/bcftools merge --merge all -O v $DATA_DIR/*vcf.gz > $OUTPUT_DIR/MERGED-GENOME.vcf
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

rm $DATA_DIR/vcf_files.txt

#-------------------------------------------------------------------------------

# End
echo '**************************************************'
exit 0
