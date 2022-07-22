library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")
option_list = list(
    make_option(c("-f", "--feature_abd"), action="store", default="CRC_abd.csv", type='character',
              help="feature_abd"),
    make_option(c("-b", "--batch"), action="store", default="CRC_abd", type='character',
              help="Batch"),
    make_option(c("-c", "--covariates"), action="store", default="study_condition", type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_meta.csv", type='character',
              help="Batch"),
    make_option(c("-o", "--output"), action="store", default="output1", type='character',
              help="output file")
    )
opt = parse_args(OptionParser(option_list=option_list))

CRC_abd  <- read.csv(file = opt$feature_abd)
CRC_meta <- read.csv(file = opt$data)


abd1 <- read.csv(file = opt$feature_abd , header = TRUE , check.names = FALSE )
colnames(abd1)[1] <- "X"
rownames(abd1) <- abd1$X
abd2 <- select(abd1, -X)

meta1 <- read.csv(file = opt$data, header = TRUE, check.names = FALSE)
colnames(meta1)[1] <- "Y"
rownames(meta1) <- meta1$Y
meta2 <- select(meta1, -Y)







fit_adjust_batch <- adjust_batch(feature_abd = abd2,
                                 batch = opt$batch,
                                 covariates = opt$covariates,
                                 data = meta2,
                                 control = list(verbose = FALSE))


CRC_abd_adj <- fit_adjust_batch$feature_abd_adj

write.csv(CRC_abd_adj, "CRC_abd_adj.csv", row.names=TRUE)
