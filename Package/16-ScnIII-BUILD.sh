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

# This script builds the vcf for ScnIII from the vcf for ScnI in a Linux
# environment.

#-------------------------------------------------------------------------------

# Control parameters

if [ -n "$*" ]; then echo 'This script does not have parameters'; exit 1; fi

#-------------------------------------------------------------------------------

# Set run environment


DATA_DIR=PATH_TO_YOUR_DATA_DIRECTORY		# where ScnI-PROGENIES-IMPUTED.vcf  and IDs-total file are stored
OUTPUT_DIR=PATH_TO_YOUR_RESULTS_DIRECTORY
cd $WD

# Execute the sed command on ScnB
sed 's/99\/99/.\/./g' ScnI-PROGENIES-IMPUTED.vcf > ScnI-PROGENIES-IMPUTED_.vcf
sed 's/\/99/\/./g' ScnI-PROGENIES-IMPUTED_.vcf > ScnIII-PROGENIES-IMPUTED.vcf

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
        
#-------------------------------------------------------------------------------

# End

echo
echo '**************************************************'
exit 0

#-------------------------------------------------------------------------------

