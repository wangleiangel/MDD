# 01 DEGs + 火山图 + 热图
rm(list=ls())
set.seed(123)
library(limma)
library(ggplot2)
library(pheatmap)
library(ggrepel)

exp <- read.csv("data/demo_expression.csv", row.names=1)
cli <- read.csv("data/demo_clinical.csv", row.names=1)
group <- factor(cli$Group)

DEGs_affy <- function(data, group_list){
  design <- model.matrix(~0+group_list)
  colnames(design) <- levels(group_list)
  contr <- makeContrasts(paste(levels(group_list),collapse="-"), levels=design)
  fit <- lmFit(data, design)
  fit2 <- contrasts.fit(fit, contr)
  fit2 <- eBayes(fit2)
  res <- topTable(fit2, n=Inf)
  res <- na.omit(res)
  res$id <- rownames(res)
  return(res)
}

degs <- DEGs_affy(exp, group)
write.csv(degs, "result/DEGs_result.csv", row.names=F)

# 火山图
degs$logP <- -log10(degs$P.Value)
degs$group <- "not-DEGs"
degs$group[degs$P.Value<0.05 & degs$logFC>0.05] <- "up"
degs$group[degs$P.Value<0.05 & degs$logFC< -0.05] <- "down"

p <- ggplot(degs, aes(logFC, logP, color=group)) +
  geom_point(size=1, alpha=0.7) +
  scale_color_manual(values=c("blue","gray","red")) +
  geom_hline(yintercept=1.3, lty=2) +
  geom_vline(xintercept=c(-0.05,0.05), lty=2) +
  theme_classic()
ggsave("result/Volcano.pdf", p, width=9, height=6)

# 热图
deg_sig <- rownames(degs)[degs$P.Value<0.05 & abs(degs$logFC)>0.05]
mat <- exp[deg_sig, ]
ann <- data.frame(Group=cli$Group)
rownames(ann) <- colnames(mat)
p2 <- pheatmap(mat, scale="row", annotation_col=ann, show_rownames=F)
ggsave("result/Heatmap.pdf", p2, width=8, height=6)