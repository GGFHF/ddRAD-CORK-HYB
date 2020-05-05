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

# This script executes the program load-genomic-features.py in a Linux
# environment.

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment

NGSHELPER_DIR=PATH_TO_NGSHELPER_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where GCF_002906115.1_CorkOak1.0_genomic.gff functional annotation file is stored 
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

if [ ! -d "$OUTPUT_DIR" ]; then mkdir --parents $OUTPUT_DIR; fi

cd $NGSHELPER_DIR

#-------------------------------------------------------------------------------

# Execute the program load-genomic-features.py

/usr/bin/time \
    ./load-genomic-features.py \
        --db=$OUTPUT_DIR/ScnIII-ngshelper.db \ 
        --gff=$DATA_DIR/GCF_002906115.1_CorkOak1.0_genomic.gff \
        --format=GFF3 \
        --verbose=Y  \
        --trace=N
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#-------------------------------------------------------------------------------

# End

echo
echo '**************************************************'
exit 0

#-------------------------------------------------------------------------------
