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
    make_option(c("-c", "--covariates"), action="store", default=c("gender", "age", "BMI"), type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_meta.Rda", type='character',
              help="Batch"),
    make_option(c("-e", "--exposure"), action="store", default="study_condition", type='character',
              help="output file")
    )

opt = parse_args(OptionParser(option_list=option_list))
print(opt$feature_abd)
print(opt$data)
load(opt$feature_abd)
load(opt$data)

fit_lm_meta <- lm_meta(feature_abd = CRC_abd,
                       batch = opt$batch,
                       exposure = opt$exposure,
                       covariates = opt$covariates,
                       data = CRC_meta,
                       control = list(verbose = FALSE))

meta_fits <- fit_lm_meta$meta_fits
   
meta_fits %>% 
  filter(qval.fdr < 0.05) %>% 
  arrange(coef) %>% 
  mutate(feature = factor(feature, levels = feature)) %>% 
  ggplot(aes(y = coef, x = feature)) +
  geom_bar(stat = "identity") +
  coord_flip()
