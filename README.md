# Introduction
This repository contains analysis scripts and data associated with our manuscript

> Diaz JA, Stern DB, and Lee CE. Local adaptation despite gene flow in copepod populations across salinity and temperature gradients in the Baltic and North Seas


## Usage
Scripts are organized by snp_calling, [**demography_analysis**](demography_analysis), [**selection_analysis**](selection_analysis), and [**SFS_analysis**](SFS_analysis)

Command-line options for python scripts can be found, e.g.,`baypass2freqs_cov.py -h`

Script files for snp_calling can be found in the following GitHub repository: https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling

#### snp_calling -- SNP calling, SNP data processing
- [baypass2freqs_cov.py](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/baypass2freqs_cov.py) -- Converts a file from multipopulation BayPass format (refcount1 altcount1 etc.) to frequencies of the alt allele and a coverage matrix
- [bams2SNPs.commands.sh](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/bams2SNPs.commands.sh) -- Commands used to call SNPs and generate allele count files
- [calculate_coverage_distribution_sync.py](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/calculate_coverage_distribution_sync.py) -- Calculates the top X percentage of coverage across all pools from a sync file
- [filter_sync_by_snplist.py](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/filter_sync_by_snplist.py) -- Filters a sync file (Popoolation2) by a list of SNPs to keep (e.g. a snpdet file produced by poolfstat)
- [get_SNP_position_in_genome.py](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/get_SNP_position_in_genome.py) -- Convert SNP positions called in one reference genome to approximate position in another genome based on blast results
- [vcf2genobaypass.R](https://github.com/TheDBStern/Baltic_Lab_Wild/tree/master/snp_calling/vcf2genobaypass.R) -- R commands to generate the read count file from the VarScan VCF using *poolfstat*

#### demography_analysis -- Mantel tests
- [run.MantelTests.R](demography_analysis/run.MantelTests.R) -- generates matrices to run Mantel tests, runs Mantel tests to compare geographic distance and admixture statistic (f4) and to compare geographic distance and genetic distance (FST)

#### selection_analysis --


#### SFS_analysis --


## Software required to run these scripts
- [PoPoolation2 v1.201](https://sourceforge.net/p/popoolation2/wiki/Main/)
- [Samtools v1.3.1](http://www.htslib.org/)
- [VarScan v2.4.3](http://varscan.sourceforge.net/)

## Python packages
Python version 3.8.2
- [joblib v.1.0.1](https://joblib.readthedocs.io/en/latest/)
- [numpy v1.15.2](https://numpy.org/)

## R packages
R version 4.1.2
- [dplyr v.1.0.8](https://dplyr.tidyverse.org/)
- [ggplot2 v.3.3.5](https://ggplot2.tidyverse.org)
- [gplots v.3.1.3](https://github.com/talgalili/gplots)
- [OptM v.0.1.6](https://cran.r-project.org/web/packages/OptM/OptM.pdf)
- [poolfstat v.1.1.1, v2.1.1](https://cran.r-project.org/web/packages/poolfstat/poolfstat.pdf)
- [RColorBrewer v.1.1-3](https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf)
- [tidyverse v.1.3.1](https://www.tidyverse.org/)
- [vegan v.2.6-2](http://cran.r-project.org/package=vegan)

## Other software used in the manuscript
- [BayPass v.2.2](https://forgemia.inra.fr/mathieu.gautier/baypass_public)
- [BEDOPS v.2.4.39](https://bedops.readthedocs.io/en/latest/)
- [BITE](https://github.com/marcomilanesi/BITE)
- [BWA-MEM v.0.7.17](https://github.com/lh3/bwa)
- [GATK v.3.8](https://gatk.broadinstitute.org/hc/en-us)
- [Gowinda v.1.12](https://sourceforge.net/p/gowinda/wiki/Main/)
- [PHYLIP v.3.697](https://phylipweb.github.io/phylip/)
- [Picard v.2.18.27](https://broadinstitute.github.io/picard/)
- [PoPoolation v.1.2.2](https://sourceforge.net/p/popoolation/wiki/Main/)
- [TreeMix v.1.13](https://speciationgenomics.github.io/Treemix/)
- [Trimmomatic v.0.39](http://www.usadellab.org/cms/?page=trimmomatic)

## Data
SNPs and allele counts derived from the Pool-Seq data are available in the [**data**](data) directory, along with environmental data. Please see the README file within for information.

Please contact the authors for questions or issues.
