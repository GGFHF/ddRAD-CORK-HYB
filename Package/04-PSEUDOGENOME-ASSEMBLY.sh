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

# This script performs pseudogenome de novo assembly from non-mapped reads with Soapdenovo2 (Luo et al. 2012)
# See the manual for Soapdenovo2 functioning and parameter definition
#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

SOAPDENOVO2_DIR=PATH_TO_GSNAP_BINARIES
GENOME_DIR=PATH_TO_YOUR_GENOME_DIRECTORY/pseudogenome		#where the assembled pseudogenome file is stored
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY						#where the adult filtered read files are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

cd $SOAPDENOVO2_DIR

#-------------------------------------------------------------------------------
# Execute the program gmap_build

echo '**************************************************'
echo 'GMAP_BUILD IS BUILDING THE PSEUDOGENOME DATABASE...'
    
    $SOAPDENOVO2_DIR/SOAPdenovo-63mer all \
        -s $DATA_DIR/sdn2-process-config.txt \		#Config file for SOAPDENOVO2 needs to be created first
        -o $OUTPUT_DIR/Pseudogenome \
        -p 32 \
        -a 0 \
        -K 53 \
        -d 0 \
        -D 4 \
        -M 2 \
        -e 0 \
        -k 53 \
        -G 50 \
        -L 50 \
        -c 0.1 \
        -C 2.0 \
        -b 1.5 \
        -B 0.6 \
        -N 0
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
    
#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
