
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

# This script executes imputation for adults individuals with impute-adults.py 
# in a Linux environment.


#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment (modify parameters accordingly)

NGSHELPER_DIR=PATH_TO_NGSHELPER_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		#where CONCATENATED-UNFILTERED.vcf file (gz compress if necessary) 
											#and IDs-total file are stored (check NGShelper manual to see specifications for this file)
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

if [ ! -d "$OUTPUT_DIR" ]; then mkdir --parents $OUTPUT_DIR; fi

cd $NGSHELPER_DIR

#-------------------------------------------------------------------------------

# Execute the program impute-adults.py

echo '**************************************************'
echo 'IMPUTING ADULTS WITH IMPUTE-ADULTS.PY ...'

/usr/bin/time \
    ./impute-adults.py \
        --vcf=$DATA_DIR/CONCATENATED-UNFILTERED.vcf.gz \
        --samples=$DATA_DIR/IDs-total.txt \
        --fix=Y \
        --scenario=0 \
        --min_aa=5.0 \
        --min_mdi=90.0 \
        --imd_id=99 \
        --sp1_id=AL \
        --sp1_max_md=5.0 \
        --sp2_id=EN \
        --sp2_max_md=5.0 \
        --hyb_id=HY \
        --maf=0.0 \
        --dp=6000 \
        --out=$OUTPUT_DIR/ScnIV-ADULTS-IMPUTED.vcf \
        --verbose=Y \
        --trace=N \
        --tvi=NONE
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
