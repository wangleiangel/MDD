# 03 多算法筛选Hub基因
rm(list=ls())
library(glmnet)
library(Boruta)
library(caret)
library(tidyverse)

exp <- read.csv("data/demo_expression.csv", row.names=1)
cli <- read.csv("data/demo_clinical.csv", row.names=1)
y <- ifelse(cli$Group=="MDD",1,0)
x <- t(as.matrix(exp))

cvfit <- cv.glmnet(x, y, family="binomial")
coefs <- coef(cvfit, s="lambda.1se")
hub_lasso <- rownames(coefs)[coefs[,1]!=0][-1]

boruta <- Boruta(x=x, y=as.factor(y), doTrace=0)
hub_boruta <- getSelectedAttributes(boruta)

hub_final <- unique(c(hub_lasso, hub_boruta))
writeLines(hub_final, "result/HubGenes.txt")
cat("Final Hub Genes:", length(hub_final), "\n")
print(hub_final)