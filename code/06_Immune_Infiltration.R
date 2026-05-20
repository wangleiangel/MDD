# 06 免疫浸润
rm(list=ls())
library(IOBR)
library(GSVA)
library(ggplot2)

exp <- read.csv("data/demo_expression.csv", row.names=1)
ciber <- deconvo_tme(eset=exp, method="cibersort", arrays=T)
write.csv(ciber, "result/Immune_CIBERSORT.csv", row.names=F)

p <- ggplot(ciber, aes(Patient, Neutrophils)) + geom_col() + theme_bw()
ggsave("result/Immune_Cell_Fraction.pdf", p, width=12, height=6)