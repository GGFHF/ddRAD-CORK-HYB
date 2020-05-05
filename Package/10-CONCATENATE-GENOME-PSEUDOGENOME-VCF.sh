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

# This script concatenates the merged vcf files obtained for genome and pseudogenome

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

BCFTOOLS_DIR=PATH_TO_BCFTOOLS_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY				#where merged vcf files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

#-------------------------------------------------------------------------------                     
# Compress vcf files with bgzip from tabix (run sudo apt-get install tabix or install from source)

#echo '**************************************************'
#echo 'COMPRESSING VCF FILES WITH BGZIP ...'

# Concatenate vcf files (must have the same sample order)

echo '**************************************************'
echo 'CONCATENATING VCF FILES ...'

    $BCFTOOLS concat $DATA_DIR/MERGED-GENOME.vcf \
                     $DATA_DIR/MERGED-PSEUDOGENOME.vcf \
                     -o $DATA_DIR/CONCATENATED_UNFILTERED.vcf
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
    
#-------------------------------------------------------------------------------
    
# End
echo '**************************************************'
exit 0
