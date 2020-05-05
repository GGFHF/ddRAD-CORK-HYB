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
ScnII<-read.table("ScnII-CASO1.stru",header=TRUE, sep="")

#Subset input data by species

ScnII.AL <- subset(ScnII, ScnII$species_ID == 0)          #Q. suber
ScnII.EN <- subset(ScnII, ScnII$species_ID == 700)        #Q. ilex
ScnII.HY <- subset(ScnII, ScnII$species_ID == 3)          #Hybrids

#Check the correct subsetting of data
dim(ScnII.EN)
dim(ScnII.AL)
dim(ScnII.HY)

#Prepare data
ScnII.EN.gt <- t(as.matrix(ScnII.EN[,c(3:8177)]))
ScnII.AL.gt <- t(as.matrix(ScnII.AL[,c(3:8177)]))
ScnII.HY.gt <- t(as.matrix(ScnII.HY[,c(3:8177)]))
loci.data<-as.matrix(cbind(row.names(ScnII.HY.gt),rep("c",8177)))
colnames(loci.data)<-c("locus","type")
ScnII.CASO1<-prepare.data(admix.gen=ScnII.HY.gt, 
             loci.data=loci.data,
             parental1=ScnII.AL.gt, 
             parental2=ScnII.EN.gt,
             pop.id=FALSE, 
             ind.id=FALSE, 
             fixed=FALSE,
             sep.rows=FALSE, 
             sep.columns=TRUE)

#Estimate the Hybrid Index (Buerkle 2005)
hybrid.index<-est.h(introgress.data=ScnII.CASO1, 
                    loci.data=loci.data, 
                    ind.touse=NULL,
                    fixed=FALSE, 
                    p1.allele=NULL, 
                    p2.allele=NULL)

#Save output to csv file
write.csv(hybrid.index,"ScnII-CASO1-hybrid_index.csv")

#End
