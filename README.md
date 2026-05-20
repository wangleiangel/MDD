# MDD
# MDD_Depression_Biomarker
基于GEO公共转录组数据的抑郁症(MDD)生物标志物挖掘与模型构建

## 项目简介
本项目包含抑郁症生物信息学分析全流程代码，可复现论文图表：
- 差异基因分析(DEGs)、火山图、热图
- GO/KEGG富集分析
- 多算法筛选Hub基因(Lasso/Boruta/随机森林等)
- 诊断模型构建(Nomogram/ROC/C-index/校准曲线)
- 一致性聚类与分群差异分析
- 免疫浸润分析(CIBERSORT/ssGSEA)
- 单细胞测序可视化与验证

## 运行环境
- R ≥ 4.1.0
- 内存 ≥ 8GB
- Windows/Linux/macOS均可

## 依赖包安装
```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install(c("limma","clusterProfiler","org.Hs.eg.db","GSVA","ComplexHeatmap"))

install.packages(c(
  "ggplot2","ggpubr","pheatmap","writexl","readxl",
  "survival","glmnet","rms","pROC","VennDiagram","UpSetR",
  "ConsensusClusterPlus","IOBR","Seurat","rstatix","ggrepel"
))
