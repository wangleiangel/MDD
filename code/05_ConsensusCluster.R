# 05 一致性聚类
rm(list=ls())
library(ConsensusClusterPlus)

exp <- read.csv("data/demo_expression.csv", row.names=1)
hub <- readLines("result/HubGenes.txt")
mat <- t(exp[intersect(hub,rownames(exp)), ])
mat <- scale(mat)

set.seed(123)
cc <- ConsensusClusterPlus(mat, maxK=4, reps=50, pItem=0.8,
                            clusterAlg="pam", distance="euclidean")
cluster <- cc[[2]]$consensusClass
write.csv(data.frame(Sample=names(cluster), Cluster=cluster),
          "result/Cluster.csv", row.names=F)