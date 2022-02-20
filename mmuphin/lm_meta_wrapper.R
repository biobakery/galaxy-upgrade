library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")
option_list = list(
    make_option(c("-f", "--feature_abd"), action="store", default="CRC_abd.Rda", type='character',
              help="feature_abd"),
    make_option(c("-b", "--batch"), action="store", default="studyID", type='character',
              help="Batch"),
    make_option(c("-c", "--covariates"), action="store", default="gender,age,BMI", type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_meta.Rda", type='character',
              help="Batch"),
    make_option(c("-e", "--exposure"), action="store", default="study_condition", type='character',
              help="exposure")
    )

opt = parse_args(OptionParser(option_list=option_list))

load(opt$feature_abd)
load(opt$data)

cov0 <- gsub(' ','',opt$covariates)
cov1 <- strsplit(cov0, split = ",") 
cov2 <- as.vector(cov1)
cov3 <- cov2[[1]]

fit_lm_meta <- lm_meta(feature_abd = CRC_abd,
                       batch = opt$batch,
                       exposure = opt$exposure,
                       covariates = cov3,
                       data = CRC_meta,
                       control = list(verbose = FALSE))

meta_fits <- fit_lm_meta$meta_fits
write.csv(meta_fits, "meta_fits.csv")   

