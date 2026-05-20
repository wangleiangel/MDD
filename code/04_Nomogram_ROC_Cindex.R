# 04 诊断模型：Nomogram + ROC + C-index
rm(list=ls())
library(survival)
library(rms)
library(pROC)
library(ggplot2)

exp <- read.csv("data/demo_expression.csv", row.names=1)
cli <- read.csv("data/demo_clinical.csv", row.names=1)
hub <- readLines("result/HubGenes.txt")
hub <- intersect(hub, rownames(exp))

dat <- t(exp[hub, ])
dat <- as.data.frame(dat)
dat$Group <- ifelse(cli$Group=="MDD",1,0)

ddist <- datadist(dat)
options(datadist="ddist")
fit <- lrm(Group ~ ., data=dat)
nom <- nomogram(fit, fun=plogis, funlabel="Risk")

pdf("result/Nomogram.pdf", width=10, height=6)
plot(nom)
dev.off()

pred <- predict(fit, dat)
roc_obj <- roc(dat$Group, pred)
pdf("result/ROC.pdf", width=6, height=6)
plot(roc_obj, print.auc=T)
dev.off()

c_index <- rcorrcens(dat$Group ~ pred, data=dat)[1,1]
cat("C-index:", round(c_index,3), "\n")