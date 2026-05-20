# 07 单细胞分析（演示版）
rm(list=ls())
library(Seurat)
library(ggplot2)
library(rstatix)

# 请自行加载GSE144136对象
# load("objs_0.8.Rdata")
# scRNA <- pbmc.all

message("请自行下载GSE144136数据并加载Seurat对象")

# 示例绘图（替换为你的对象即可运行）
# p1 <- UMAPPlot(scRNA, label=T)
# ggsave("result/scRNA_UMAP.pdf", p1, width=10, height=6)
#
# p2 <- VlnPlot(scRNA, features="NUCKS1", split.by="group")
# ggsave("result/scRNA_Vln_NUCKS1.pdf", p2, width=12, height=6)