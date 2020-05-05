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

# This script builds the vcf for ScnII from the vcf for ScnI in a Linux
# environment.

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment

DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where ScnI-ADULTS-IMPUTED.vcf and selected10000_ids.txt file are stored
											# selected10000_ids.txt contains the variants selected after step J
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

cd $DATA_DIR

# Execute the program BCFTOOLS
/usr/bin/time \
$VCFTOOLSDIR/vcftools \
        --vcf $DATA_DIR/ScnI-PROGENIES-IMPUTED.vcf \
        --recode \
        --positions $DATA_DIR/selected10000_ids.txt \
        --recode-INFO-all \
        --out $OUTPUT_DIR/ScnII-PROGENIES-IMPUTED 

mv $OUTPUT_DIRScn/D-PROGENIES-IMPUTED.recode.vcf $OUTPUT_DIR/ScnII-PROGENIES-IMPUTED.vcf

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
        
#-------------------------------------------------------------------------------

# End

echo
echo '**************************************************'
exit 0

#-------------------------------------------------------------------------------

