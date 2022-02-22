library(MMUPHin)
library(magrittr)
library(dplyr)
library(ggplot2)
library("optparse")

abd1 <- read.csv(file = 'abd.csv', header = TRUE , check.names = FALSE )
colnames(abd1)[1] <- "X"
rownames(abd1) <- abd1$X
abd2 <- select(abd1, -X)

meta1 <- read.csv(file = 'meta.csv', header = TRUE, check.names = FALSE)
colnames(meta1)[1] <- "Y"
rownames(meta1) <- meta1$Y
meta2 <- select(meta1, -Y)

covariates<-  "study_condition"
batch<-  "studyID"

fit_adjust_batch <- adjust_batch(feature_abd = abd2,
                                 batch = batch,
                                 covariates = covariates,
                                 data = meta2,
                                 control = list(verbose = FALSE))

write.csv(fit_adjust_batch$feature_abd_adj, "feature_abd_adj.csv")
