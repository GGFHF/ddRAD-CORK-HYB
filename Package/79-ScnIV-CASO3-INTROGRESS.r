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

# This script performs hybrid index estimation with introgress (Gompert & Buerkle 2010).

#-------------------------------------------------------------------------------

# Install dependencies

install.packages("introgress",dependencies=TRUE)

library(introgress)

#-------------------------------------------------------------------------------


# Set run environment (modify parameters accordingly)

WD<-"PATH_TO_YOUR_WORKING_DIRECTORY"
setwd(WD)

#Load introgress input data (modify .stru files accordingly)
ScnIV<-read.table("ScnIV-CASO3.stru",header=TRUE, sep="")

#Subset input data by species

ScnIV.AL <- subset(ScnIV, ScnIV$species_ID == 0)          #Q. suber
ScnIV.EN <- subset(ScnIV, ScnIV$species_ID == 700)        #Q. ilex
ScnIV.HY <- subset(ScnIV, ScnIV$species_ID == 3)          #Hybrids

#Check the correct subsetting of data
dim(ScnIV.EN)
dim(ScnIV.AL)
dim(ScnIV.HY)

#Prepare data
ScnIV.EN.gt <- t(as.matrix(ScnIV.EN[,c(3:6003)]))
ScnIV.AL.gt <- t(as.matrix(ScnIV.AL[,c(3:6003)]))
ScnIV.HY.gt <- t(as.matrix(ScnIV.HY[,c(3:6003)]))
loci.data<-as.matrix(cbind(row.names(ScnIV.HY.gt),rep("c",6001)))
colnames(loci.data)<-c("locus","type")
ScnIV.CASO3<-prepare.data(admix.gen=ScnIV.HY.gt, 
             loci.data=loci.data,
             parental1=ScnIV.AL.gt, 
             parental2=ScnIV.EN.gt,
             pop.id=FALSE, 
             ind.id=FALSE, 
             fixed=FALSE,
             sep.rows=FALSE, 
             sep.columns=TRUE)

#Estimate the Hybrid Index (Buerkle 2005)
hybrid.index<-est.h(introgress.data=ScnIV.CASO3, 
                    loci.data=loci.data, 
                    ind.touse=NULL,
                    fixed=FALSE, 
                    p1.allele=NULL, 
                    p2.allele=NULL)

#Save output to csv file
write.csv(hybrid.index,"ScnIV-CASO3-hybrid_index.csv")

#End
