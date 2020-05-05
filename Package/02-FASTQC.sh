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

# This script performs read quality assessment with fastqc (Andrews 2010).

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

FASTQC_DIR=PATH_TO_FASTQC_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY			#where your filtered read files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

cd $FASTQC
chmod 755 fastqc

#-------------------------------------------------------------------------------
# Execute the program fastqc

echo '**************************************************'
echo 'Decompressing FASTQ.GZ FILES...'
gzip -d $DATA_DIR/*trimmed.fastq.gz
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi


echo '**************************************************'
echo 'Running FASTQC ...'

$FASTQC_DIR/fastqc $DATA_DIR/*trimmed.fastq.gz --outdir=$OUTPUT_DIR --extract
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi


#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
