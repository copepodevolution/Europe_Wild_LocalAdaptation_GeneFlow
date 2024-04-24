library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)

###Generate folded site frequency spectra (SFS) for population groupings (i.e., all populations, Baltic populations, North populations)
#The code below describes the process to get the SFS for all populations based on the XtX results -> edit/adjust as needed for other BayPass analyses/population groupings

##Read input files
#Input file for allelefreqs should be the FOLDED SNP frequency file (the file on the Github is the UNFOLDED SNP frequency file)

allelefreqs <- read.delim("path to folded SNP frequency file", header = FALSE, sep = " ") %>% 
  set_colnames(c("BB1E", "BB2E", "GBE", "HFE", "IJE", "KIE", "MME", "RG1E", "RG2E", "SCE", "STE"))

snpdet <- read.delim("path to wild.snpdet file", header = TRUE, sep = " ") %>% 
  select(Pseudo_Transcript, Pseudo_Position)

all_sigxtx <- read.delim("path to list of SNPs that were significant for the all populations XtX BayPass analysis", header = TRUE, sep = "\t") %>% 
  select(Pseudo_Transcript, Pseudo_Position)


##Merge snpdet with allelefreqs -> give each SNP an identifier so significant and not significant SNPs can be identified

allelefreqs_ID <- cbind(snpdet, allelefreqs)

#Split data set into various chunks - populations >5 PSU, populations <5 PSU, SNPs significant for signatures of selection, SNPs not significant for signatures of selection, etc.

#Alleles frequencies using just fresh and just salt populations

freshpops_all_allelefreqs_ID <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, BB1E, BB2E, GBE, IJE, MME)

saltpops_all_allelefreqs_ID <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, SFE, KIE, RG1E, RG2E, SCE, STE)

#Candidate SNP lists - empirical data (code shows process with empirical data, the same process is used with the simulated data)

allpops_sigxtx_freqs <- left_join(all_sigxtx, allelefreqs_ID)

freshpops_all_sigxtx_freqs <- left_join(all_sigxtx, freshpops_all_allelefreqs_ID)

saltpops_all_sigxtx_freqs <- left_join(all_sigxtx, saltpops_all_allelefreqs_ID)

#Neutral SNP lists - empirical data

allpops_notsigxtx_freqs <- anti_join(allelefreqs_ID, all_sigxtx)

freshpops_all_notsigxtx_freqs <- anti_join(freshpops_all_allelefreqs_ID, all_sigxtx)

saltpops_all_notsigxtx_freqs <- anti_join(saltpops_all_allelefreqs_ID, all_sigxtx)

##Summarize allele frequency across populations

#Generate MAF average per SNP across population groups - empirical data

allpops_sigxtx_avg <- allpops_sigxtx_freqs %>% 
  select(BB1E, BB2E, GBE, SFE, IJE, KIE, MME, RG1E, RG2E, SCE, STE) %>% 
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "allpops_sigxtx_avg_MAF")

freshpops_all_sigxtx_avg <- freshpops_all_sigxtx_freqs %>% 
  select(BB1E, BB2E, GBE, IJE, MME) %>%
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "fresh_all_sigxtx_avg_MAF")

saltpops_all_sigxtx_avg <- saltpops_all_sigxtx_freqs %>% 
  select(SFE, KIE, RG1E, RG2E, SCE, STE) %>%
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "salt_all_sigxtx_avg_MAF")

allpops_notsigxtx_avg <- allpops_notsigxtx_freqs %>% 
  select(BB1E, BB2E, GBE, SFE, IJE, KIE, MME, RG1E, RG2E, SCE, STE) %>% 
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "allpops_notsigxtx_avg_MAF")

freshpops_all_notsigxtx_avg <- freshpops_all_notsigxtx_freqs %>% 
  select(BB1E, BB2E, GBE, IJE, MME) %>%
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "fresh_all_notsigxtx_avg_MAF")

saltpops_all_notsigxtx_avg <- saltpops_all_notsigxtx_freqs %>% 
  select(SFE, KIE, RG1E, RG2E, SCE, STE) %>%
  rowMeans() %>% 
  data.frame() %>% 
  rename(replace = c("." = "avg_MAF")) %>% 
  add_column(name = "salt_all_notsigxtx_avg_MAF")

#Combine various population MAF averages to make one data set to use for histograms - empirical data

allpops_signotsig_xtx_avg <- rbind(allpops_sigxtx_avg, allpops_notsigxtx_avg)

freshpops_all_signotsig_xtx_avg <- rbind(freshpops_all_sigxtx_avg, freshpops_all_notsigxtx_avg)

saltpops_all_signotsig_xtx_avg <- rbind(saltpops_all_sigxtx_avg, saltpops_all_notsigxtx_avg)

freshsalt_all_signotsig_xtx_avg <- rbind(freshpops_all_sigxtx_avg, freshpops_all_notsigxtx_avg, saltpops_all_sigxtx_avg, saltpops_all_notsigxtx_avg)

###Generate folded SFS

#Sig vs. non-sig SNPs, all populations, XtX

allpops_signotsig_xtx_avg_meanlines <- ddply(allpops_signotsig_xtx_avg, "name", summarize, grp.mean = mean(avg_MAF))

plot <- ggplot(allpops_signotsig_xtx_avg, aes(x = avg_MAF, fill = name)) +
  geom_histogram(binwidth = 0.05, position = "dodge", aes(y = ..density..)) +
  geom_vline(data = allpops_signotsig_xtx_avg_meanlines, aes(xintercept = grp.mean, color = name), linetype = "longdash", size = 1.3) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank()) +
  theme(legend.key.size = unit(1, "cm")) +
  theme(axis.text = element_text(size = 18), axis.title = element_text(size = 20), legend.text = element_text(size = 20), plot.title = element_text(size = 30)) +
  scale_fill_manual(values = c("#696969", "#68228B"), labels = c("Neutral SNPs", "Candidate SNPs")) +
  scale_color_manual(values = c("#696969", "#68228B"), labels = c("Neutral SNPs", "Candidate SNPs")) +
  labs(title = "All Populations - XtX", x = "Minor Allele Frequency", y = "Density")

#fresh vs. salt MAF, sig vs. non-sig SNPs, all populations, XtX

freshsalt_all_signotsig_xtx_avg_meanlines <- ddply(freshsalt_all_signotsig_xtx_avg, "name", summarize, grp.mean = mean(avg_MAF))

plot <- ggplot(freshsalt_all_signotsig_xtx_avg, aes(x = avg_MAF, fill = name)) +
  geom_histogram(binwidth = 0.05, position = "dodge", aes(y = ..density..)) +
  geom_vline(data = freshsalt_all_signotsig_xtx_avg_meanlines, aes(xintercept = grp.mean, color = name), linetype = "longdash", size = 1) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank()) +
  theme(legend.key.size = unit(1, "cm")) +
  theme(axis.text = element_text(size = 18), axis.title = element_text(size = 20), legend.text = element_text(size = 15), plot.title = element_text(size = 30)) +
  scale_fill_manual(values = c("#A1A1A1", "#DDA0DD", "#696969", "#68228B"), labels = c("Fresh neut SNPs", "Fresh cand SNPs", "Salt neut SNPs", "Salt cand SNPs")) +
  scale_color_manual(values = c("#A1A1A1", "#DDA0DD", "#696969", "#68228B"), labels = c("Fresh neut mMAF", "Fresh cand mMAF", "Salt neut mMAF", "Salt cand mMAF")) +
  labs(title = "All Populations - XtX", x = "Minor Allele Frequency", y = "Density")

##Run Kolmorgorov-Smirnov tests on histogram groups to determine if the difference in MAF between groups is significant.

#All populations, neutral vs. candidate SNPs

all_sigxtx_avg_ks <- all_sigxtx_avg %>% 
  select(avg_MAF)
all_sigxtx_avg_ks <- as.numeric(unlist(all_sigxtx_avg_ks))
all_notsigxtx_avg_ks <- all_notsigxtx_avg %>% 
  select(avg_MAF)
all_notsigxtx_avg_ks <- as.numeric(unlist(all_notsigxtx_avg_ks))
ks.test(all_sigxtx_avg_ks, all_notsigxtx_avg_ks)

#All populations, fresh pops, XtX, neutral vs. candidate SNPs

freshpops_all_sigxtx_avg_ks <- freshpops_all_sigxtx_avg %>% 
  select(avg_MAF)
freshpops_all_sigxtx_avg_ks <- as.numeric(unlist(freshpops_all_sigxtx_avg_ks))
freshpops_all_notsigxtx_avg_ks <- freshpops_all_notsigxtx_avg %>% 
  select(avg_MAF)
freshpops_all_notsigxtx_avg_ks <- as.numeric(unlist(freshpops_all_notsigxtx_avg_ks))
ks.test(freshpops_all_sigxtx_avg_ks, freshpops_all_notsigxtx_avg_ks)

#All populations, salt pops, XtX, neutral vs. candidate SNPs

saltpops_all_sigxtx_avg_ks <- saltpops_all_sigxtx_avg %>% 
  select(avg_MAF)
saltpops_all_sigxtx_avg_ks <- as.numeric(unlist(saltpops_all_sigxtx_avg_ks))
saltpops_all_notsigxtx_avg_ks <- saltpops_all_notsigxtx_avg %>% 
  select(avg_MAF)
saltpops_all_notsigxtx_avg_ks <- as.numeric(unlist(saltpops_all_notsigxtx_avg_ks))
ks.test(saltpops_all_sigxtx_avg_ks, saltpops_all_notsigxtx_avg_ks)

#Fresh vs. salt, all populations, XtX

freshpops_all_sigxtx_avg_ks <- freshpops_all_sigxtx_avg %>% 
  select(avg_MAF)
freshpops_all_sigxtx_avg_ks <- as.numeric(unlist(freshpops_all_sigxtx_avg_ks))
saltpops_all_sigxtx_avg_ks <- saltpops_all_sigxtx_avg %>% 
  select(avg_MAF)
saltpops_all_sigxtx_avg_ks <- as.numeric(unlist(saltpops_all_sigxtx_avg_ks))
ks.test(freshpops_all_sigxtx_avg_ks, saltpops_all_sigxtx_avg_ks)


###Generate folded site frequency spectra (SFS) for individual populations

##create allele frequency lists for each population to be used in allele frequency histograms for each individual population for each test

bb1e_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, BB1E)
bb2e_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, BB2E)
gbe_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, GBE)
hfe_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, HFE)
ije_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, IJE)
kie_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, KIE)
mme_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, MME)
rg1e_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, RG1E)
rg2e_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, RG2E)
sce_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, SCE)
ste_allelefreq <- allelefreqs_ID %>% 
  select(Pseudo_Transcript, Pseudo_Position, STE)

#The code below describes the process to get the SFS for BB1E based on the XtX results -> edit/adjust as needed for other BayPass analyses/population
#Code shows process with empirical data, the same process is used with the simulated data

##Split data set into various chunks - SNPs significant for signatures of selection, SNPs not significant for signatures of selection, etc.
#For each population, the significant SNP list is taken from the corresponding BayPass analyses for the sea the population is in (e.g., BB1E uses the Baltic populations significant SNP list, IJE uses the North populations significant SNP list)

bb1e_baltic_sigxtx <- left_join(baltic_sigxtx, bb1e_allelefreq) %>% 
  add_column(name = "BB1E_baltic_sigxtx")

bb1e_baltic_notsigxtx <- anti_join(bb1e_allelefreq, baltic_sigxtx) %>% 
  add_column(name = "BB1E_baltic_notsigxtx")

##Combine sig and not-sig SNP lists for each population to display on histograms 

bb1e_baltic_signotsig_xtx <- rbind(bb1e_baltic_sigxtx, bb1e_baltic_notsigxtx)

##Generates folded SFS

#BB1E, XtX values from Baltic populations analysis
bb1e_baltic_signotsig_xtx_meanlines <- ddply(bb1e_baltic_signotsig_xtx, "name", summarize, grp.mean = mean(BB1E))

plot <- ggplot(bb1e_baltic_signotsig_xtx, aes(x = BB1E, fill = name)) +
  geom_histogram(binwidth = 0.05, position = "dodge", aes(y = ..density..)) +
  geom_vline(data = bb1e_baltic_signotsig_xtx_meanlines, aes(xintercept = grp.mean, color = name), linetype = "longdash", size = 1.3) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank()) +
  theme(legend.key.size = unit(1, "cm")) +
  theme(axis.text = element_text(size = 18), axis.title = element_text(size = 20), legend.text = element_text(size = 20), plot.title = element_text(size = 30)) +
  scale_fill_manual(values = c("#696969", "#68228B"), labels = c("Neutral SNPs", "Candidate SNPs")) +
  scale_color_manual(values = c("#696969", "#68228B"), labels = c("Neutral SNPs", "Candidate SNPs")) +
  labs(title = "BB1E - XtX Baltic Candidates", x = "Minor Allele Frequency", y = "Density")

##run Kolmorgorov-Smirnov tests on individual histograms to determine if the difference in distribution between candidate and neutral SNPs is significant

#BB1E, baltic populations, XtX, candidate vs. neutral
bb1e_baltic_sigxtx_ks <- bb1e_baltic_sigxtx %>% 
  select(BB1E)
bb1e_baltic_sigxtx_ks <- as.numeric(unlist(bb1e_baltic_sigxtx_ks))
bb1e_baltic_notsigxtx_ks <- bb1e_baltic_notsigxtx %>% 
  select(BB1E)
bb1e_baltic_notsigxtx_ks <- as.numeric(unlist(bb1e_baltic_notsigxtx_ks))
ks.test(bb1e_baltic_sigxtx_ks, bb1e_baltic_notsigxtx_ks)