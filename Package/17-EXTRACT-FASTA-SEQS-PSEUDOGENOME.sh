
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

# This script extracts the fasta sequences of the pseudogenome that had SNPs after imputation and filterin
# using extract-fasta-seqs.py 


#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment

NGSHELPER_DIR=PATH_TO_NGSHELPER_BINARIES
DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where ScnB-ADULTS-IMPUTED.vcf and Loci_IDs.txt file are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY

if [ ! -d "$OUTPUT_DIR" ]; then mkdir --parents $OUTPUT_DIR; fi

cd $NGSHELPER_DIR

#-------------------------------------------------------------------------------

# Execute the program extract-fasta-seqs.py

/usr/bin/time \
    ./extract-fasta-seqs.py \
        --fasta=$DATA_DIR/Pseudogenome.fasta \
        --id=$DATA_DIR/Loci_IDs.txt \
        --type=LITERAL \
        --extract=$OUTPUT_DIR/PseudogenomeSNPs.fasta \
        --verbose=Y  \
        --trace=N
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#-------------------------------------------------------------------------------

# End

exit 0

#-------------------------------------------------------------------------------
