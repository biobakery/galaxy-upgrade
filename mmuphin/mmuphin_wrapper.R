library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")
option_list = list(
    make_option(c("-f", "--feature_abd"), action="store", default="CRC_abd.Rda", type='character',
              help="feature_abd"),
    make_option(c("-b", "--batch"), action="store", default="CRC_abd", type='character',
              help="Batch"),
    make_option(c("-c", "--covariates"), action="store", default="study_condition", type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_abd.Rda", type='character',
              help="Batch")
    )

opt = parse_args(OptionParser(option_list=option_list))
print("in the program")
print(opt$feature_abd)
print(opt$batch)
print(opt$covariates)
print(opt$data)
print("Going to load")
load(opt$feature_abd)
load(opt$data)

ls()
print("after load")
print("going to invoke the program")
print('Here')
fit_adjust_batch <- adjust_batch(feature_abd = CRC_abd,
                                 batch = opt$batch,
                                 covariates = opt$covariates,
                                 data =,CRC_meta,
                                 control = list(verbose = FALSE))

CRC_abd_adj <- fit_adjust_batch$feature_abd_adj
save(CRC_abd_adj,file="o1.Rda")
browser()

