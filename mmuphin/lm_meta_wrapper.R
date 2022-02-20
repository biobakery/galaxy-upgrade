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
    make_option(c("-x", "--xcovariates"), action="store", default=c("gender", "age", "BMI"), type='character',
              help="xcovariates"),
    make_option(c("-c", "--covariates"), action="store", default="gender, age, BMI", type='character',
              help="covariates"),
    make_option(c("-d", "--data"), action="store", default="CRC_meta.Rda", type='character',
              help="Batch"),
    make_option(c("-e", "--exposure"), action="store", default="study_condition", type='character',
              help="output file")
    )

opt = parse_args(OptionParser(option_list=option_list))
load(opt$feature_abd)
load(opt$data)
cov0 <- gsub(' ','',opt$covariates)
cov1 <- strsplit(cov0, split = ",") 
cov2 <- as.vector(cov1)
xx <-vector()
xx<-append(cov2[[1]][1],xx)
xx<-append(cov2[[1]][2],xx,after = 1)
xx<-append(cov2[[1]][3],xx, after = 2)
yy <- cov2[[1]]
browser()

fit_lm_meta <- lm_meta(feature_abd = CRC_abd,
                       batch = opt$batch,
                       exposure = opt$exposure,
                       covariates = yy,
                       data = CRC_meta,
                       control = list(verbose = FALSE))

meta_fits <- fit_lm_meta$meta_fits
   
print("Creating graph")
meta_fits %>% 
  filter(qval.fdr < 0.05) %>% 
  arrange(coef) %>% 
  mutate(feature = factor(feature, levels = feature)) %>% 
  ggplot(aes(y = coef, x = feature)) +
  geom_bar(stat = "identity") +
  coord_flip()

print("Program ended")
