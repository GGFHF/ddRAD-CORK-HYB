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

# This script executes  the program query-data2scenarioB.py in a Linux
# environment.

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment

NGSHELPER_DIR=PATH_TO_NGSHELPER_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where ScnI-ngshelper.db file is stored 
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

if [ ! -d "$OUTPUT_DIR" ]; then mkdir --parents $OUTPUT_DIR; fi

cd $NGSHELPER_DIR

#-------------------------------------------------------------------------------

# Execute the program query-data2scenarioB.py

/usr/bin/time \
    ./query-data2scenarioB.py \
        --db=$DATA_DIR/ScnI-ngshelper.db \
        --sp1_id=AL \
        --sp2_id=EN \
        --hyb_id=HY \
        --imd_id=99 \
        --maxsep=10000 \
        --outdir=$OUTPUT_DIR \
        --verbose=Y \
        --trace=N \
        --tsi=NW_019828847.1
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
