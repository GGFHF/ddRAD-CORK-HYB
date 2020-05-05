
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

# This script executes the program build-allele-frequency.py 
# in a Linux environment.

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment

NGSHELPER_DIR=PATH_TO_NGSHELPER_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where ScnIII-PROGENIES-IMPUTED.vcf and IDs-total.txt file are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

if [ ! -d "$OUTPUT_DIR" ]; then mkdir --parents $OUTPUT_DIR; fi

cd $NGSHELPER_DIR

#-------------------------------------------------------------------------------

# Execute the program build-allele-frequency.py


/usr/bin/time \
    ./build-allele-frequency.py \
        --vcf=$DATA_DIR/ScnIII-PROGENIES-IMPUTED.vcf \
        --samples=$DATA_DIR/IDs-total.txt \
        --sp1_id=AL \
        --sp2_id=EN \
        --hyb_id=HY \
        --out=$OUTPUT_DIR/ScnIII-PROGENIES-IMPUTED-allelefreq.csv \
        --varnum=1000 \
        --trans=ADD100 \
        --verbose=Y \
        --trace=N \
        --tvi=NONE
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi



#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
