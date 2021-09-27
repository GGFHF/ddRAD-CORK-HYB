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

# This script convert sam alignments obtained from gsnap/gmap with Q. suber reference genome
# to compressed bam, sorts these files by position, and performs variant calling to obtain 
# individual vcf files

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment (modify parameters accordingly)
SAMTOOLS_DIR=PATH_TO_SAMTOOLS_BINARIES
BCFTOOLS_DIR=PATH_TO_BCFTOOLS_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY				#where alignment sam files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY
GENOME_DIR=PATH_TO_YOUR_GENOME_DIRECTORY

# Convert SAM files to BAM, SORTED_BAM and VCF format

echo '**************************************************'
echo 'SAM FILES ARE BEING CONVERTED IN BAM,  AND VCF FORMAT ...'

ls $DATA_DIR/*.sam > $DATA_DIR/sam-files.txt

while read FILE_SAM; do

    FILE_BAM=`echo $FILE_SAM | sed 's/.sam/.bam/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    FILE_BAM_STATS=`echo $FILE_SAM | sed 's/.sam/-stats-bam.txt/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    FILE_SORTED_BAM=`echo $FILE_SAM | sed 's/.sam/.sorted.bam/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`
    FILE_VCF=`echo $FILE_SAM | sed 's/.sam/.vcf/g' | sed "s|$DATA_DIR|$OUTPUT_DIR|g"`

    # convert SAM file to BAM format
    $SAMTOOLSDIR/samtools view -Su $FILE_SAM >$FILE_BAM
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
    
    # get aligment statistic in a file
    $SAMTOOLSDIR/samtools flagstat $FILE_BAM >$FILE_BAM_STATS
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
 
    # sort the BAM file
    $SAMTOOLSDIR/samtools sort -o $FILE_SORTED_BAM $FILE_BAM
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
    
    # index the BAM file
    $SAMTOOLSDIR/samtools index $FILE_SORTED_BAM
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

    # convert SORTED_BAM file to VCF format
    $BCFTOOLS/bcftools  mpileup -g -f $GENOME_DIR/GCF_002906115.1_CorkOak1.0_genomic.fna $FILE_SORTED_BAM | $BCFTOOLS/bcftools call -m > $FILE_VCF
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi    

done < $DATA_DIR/sam-files.txt

rm $DATA_DIR/sam-files.txt

#-------------------------------------------------------------------------------

# End
echo '**************************************************'
exit 0

#-------------------------------------------------------------------------------
