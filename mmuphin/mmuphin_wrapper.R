library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")
print("In this library")
option_list = list(
    make_option(c("-f", "--feature_abd"), action="store", default="CRC_abd.Rda", type='character',
              help="feature_abd"),
    make_option(c("-b", "--batch"), action="store", default="CRC_abd", type='character',
              help="Batch"),
    make_option(c("-c", "--covariates"), action="store", default="study_condition", type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_abd.Rda", type='character',
              help="Batch"),
    make_option(c("-o", "--output"), action="store", default="output1", type='character',
              help="output file")
    )

opt = parse_args(OptionParser(option_list=option_list))
print(opt$feature_abd)
load(opt$feature_abd)
load(opt$data)

fit_adjust_batch <- adjust_batch(feature_abd = CRC_abd,
                                 batch = opt$batch,
                                 covariates = opt$covariates,
                                 data = CRC_meta,
                                 control = list(verbose = FALSE))

print("After the function")
ls()

CRC_abd_adj <- fit_adjust_batch$feature_abd_adj
print("after the copy")
ls()

save(CRC_abd_adj,file=opt$output)
print("After the program")
print("******* after****")
