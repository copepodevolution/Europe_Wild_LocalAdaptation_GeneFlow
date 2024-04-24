library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)

##Input data files and generate dataset that contains both input files
#Input files should be tab delimited and include a header with the following data columns: Trancscript (name of the pseudo-reference transcript each SNP is found on), Position (position on transcript for each SNP), XtX or eBP (BayPass results statistic, name depends on input file)

analysis1 <- read.delim("path to input file 1", header = TRUE, sep = "\t")
analysis1 <- analysis1 %>% 
  rename(Analysis1_BayPass = XtX/eBP)

analysis2 <- read.delim("path to input file 2", header = TRUE, sep = "\t")
analysis2 <- analysis2 %>% 
  rename(Analysis2_BayPass = XtX/eBP)

analysis1vs2 <- left_join(analysis1, analysis2, by = c("Transcript", "Position"))
analysis1vs2 <- analysis1vs2 %>% 
  drop_na()

##Plot comparison graph
#yintercept and xintercept should be populated with the significance threshold for the corresponding analysis - 1 is only there as a placeholder

plot <- ggplot(analysis1vs2, mapping = aes(x = Analysis1_BayPass, y = Analysis2_BayPass)) +
  geom_point() +
  geom_hline(yintercept = 1, color = "red", linetype = "dashed", size = 1.3) +
  geom_vline(xintercept = 1, color = "red", linetype = "dashed", size = 1.3) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(axis.text = element_text(size = 18), axis.title = element_text(size = 20), plot.title = element_text(size = 30)) +
  labs(title = "Figure Title", x = "X-axis Label (Analysis 1)", y = "Y-axis Label (Analysis 2)")

##Test for correlation between the results of the two BayPass analyses
#Check to see if BayPass results are normally distributed using the Shapiro-Wilk test

analysis1_normalitytest <- analysis1 %>% 
  select(analysis1_BayPass)
analysis1_normalitytest <- as.numeric(unlist(analysis1_normalitytest)) %>% 
  sample(size = 5000)
shapiro.test(as.numeric(analysis1_normalitytest))

analysis2_normalitytest <- analysis2 %>% 
  select(analysis2_BayPass)
analysis2_normalitytest <- as.numeric(unlist(analysis2_normalitytest)) %>% 
  sample(size = 5000)
shapiro.test(as.numeric(analysis2_normalitytest))

#Check to see if BayPass results are normally distributed using Q-Q plots
p <-ggqqplot(analysis1_normalitytest, ylab = "Analysis 1")
p <-ggqqplot(analysis2_normalitytest, ylab = "Analysis 2")

#BayPass results were not normally distributed, so use Spearman's rank correlation test
cor.test(analysis1vs2$Analysis1_BayPass, analysis1vs2$Analysis2_BayPass_Results, method = "spearman")