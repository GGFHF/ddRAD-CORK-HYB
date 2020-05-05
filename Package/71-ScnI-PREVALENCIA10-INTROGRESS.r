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
ScnI<-read.table("ScnI-PREVALENCIA10.stru",header=TRUE, sep="")

#Subset input data by species

ScnI.AL <- subset(ScnI, ScnI$species_ID == 0)          #Q. suber
ScnI.EN <- subset(ScnI, ScnI$species_ID == 700)        #Q. ilex
ScnI.HY <- subset(ScnI, ScnI$species_ID == 3)          #Hybrids

#Check the correct subsetting of data
dim(ScnI.EN)
dim(ScnI.AL)
dim(ScnI.HY)

#Prepare data
ScnI.EN.gt <- t(as.matrix(ScnI.EN[,c(3:9437)]))
ScnI.AL.gt <- t(as.matrix(ScnI.AL[,c(3:9437)]))
ScnI.HY.gt <- t(as.matrix(ScnI.HY[,c(3:9437)]))
loci.data<-as.matrix(cbind(row.names(ScnI.HY.gt),rep("c",9435)))
colnames(loci.data)<-c("locus","type")
ScnI.PREVALENCIA10<-prepare.data(admix.gen=ScnI.HY.gt, 
             loci.data=loci.data,
             parental1=ScnI.AL.gt, 
             parental2=ScnI.EN.gt,
             pop.id=FALSE, 
             ind.id=FALSE, 
             fixed=FALSE,
             sep.rows=FALSE, 
             sep.columns=TRUE)

#Estimate the Hybrid Index (Buerkle 2005)
hybrid.index<-est.h(introgress.data=ScnI.PREVALENCIA10, 
                    loci.data=loci.data, 
                    ind.touse=NULL,
                    fixed=FALSE, 
                    p1.allele=NULL, 
                    p2.allele=NULL)

#Save output to csv file
write.csv(hybrid.index,"ScnI-PREVALENCIA10-hybrid_index.csv")

#End
