# 02 GO/KEGG富集
rm(list=ls())
library(clusterProfiler)
library(org.Hs.eg.db)
library(ggplot2)

degs <- read.csv("result/DEGs_result.csv", row.names="id")
genes <- rownames(degs)[degs$P.Value<0.05 & abs(degs$logFC)>0.05]

eg <- mapIds(org.Hs.eg.db, keys=genes, keytype="SYMBOL", column="ENTREZID")
eg <- eg[!is.na(eg)]

# GO
go <- enrichGO(eg, OrgDb=org.Hs.eg.db, ont="ALL", pAdjustMethod="BH", qvalueCutoff=0.05)
write.csv(as.data.frame(go), "result/GO_enrich.csv", row.names=F)

# 条形图
p <- dotplot(go, showCategory=15) + theme_bw()
ggsave("result/GO_dotplot.pdf", p, width=10, height=6)

# KEGG
kegg <- enrichKEGG(eg, organism="hsa", pvalueCutoff=0.05)
if(!is.null(kegg)){
  write.csv(as.data.frame(kegg), "result/KEGG_enrich.csv", row.names=F)
  p2 <- dotplot(kegg, showCategory=15)
  ggsave("result/KEGG_dotplot.pdf", p2, width=10, height=6)
}