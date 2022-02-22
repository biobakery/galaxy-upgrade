library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")
option_list = list(
    make_option(c("-f", "--feature_abd"), action="store", default="CRC_abd.Rda", type='character',
              help="feature_abd"),
    make_option(c("-d", "--data"), action="store", default="CRC_meta.Rda", type='character',
              help="metadata"),	   
    make_option(c("-b", "--batch"), action="store", default="studyID", type='character',
              help="Batch"),
    make_option(c("-e", "--exposure"), action="store", default="study_condition", type='character',
              help="exposure"),	   
   make_option(c("-c", "--covariates"), action="store", default="gender,age,BMI", type='character',
              help="covariates")
    )

opt = parse_args(OptionParser(option_list=option_list))


cov0 <- gsub(' ','',opt$covariates)
cov1 <- strsplit(cov0, split = ",") 
cov2 <- as.vector(cov1)
cov3 <- cov2[[1]]

abd1 <- read.csv(file = opt$feature_abd , header = TRUE , check.names = FALSE )
colnames(abd1)[1] <- "X"
rownames(abd1) <- abd1$X
abd2 <- select(abd1, -X)

meta1 <- read.csv(file = opt$data, header = TRUE, check.names = FALSE)
colnames(meta1)[1] <- "Y"
rownames(meta1) <- meta1$Y
meta2 <- select(meta1, -Y)



fit_lm_meta <- lm_meta(feature_abd = abd2,
                       batch = opt$batch,
                       exposure = opt$exposure,
                       covariates = cov3,
                       data = meta2,
                       control = list(verbose = FALSE))

meta_fits <- fit_lm_meta$meta_fits
write.csv(meta_fits, "meta_fits.csv")   

