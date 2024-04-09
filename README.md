# Introduction
This repository contains analysis scripts and data associated with our manuscript

> Diaz JA, Stern DB, and Lee CE. Local adaptation despite gene flow in copepod populations across salinity and temperature gradients in the Baltic and North Seas


## Usage
Scripts are organized by snp_calling, [**demography_analysis**](demography_analysis), [**selection_analysis**](selection_analysis), and [**SFS_analysis**](SFS_analysis)

Command-line options for python scripts can be found, e.g.,`baypass2freqs_cov.py -h`

Script files for snp_calling can be found in the following GitHub repository: https://github.com/TheDBStern/Baltic_Lab_Wild/snp_calling

#### snp_calling -- SNP calling, SNP data processing
- baypass2freqs_cov.py -- Converts a file from multipopulation BayPass format (refcount1 altcount1 etc.) to frequencies of the alt allele and a coverage matrix
- bams2SNPs.commands.sh -- Commands used to call SNPs and generate allele count files
- calculate_coverage_distribution_sync.py -- Calculates the top X percentage of coverage across all pools from a sync file
- filter_sync_by_snplist.py -- Filters a sync file (Popoolation2) by a list of SNPs to keep (e.g. a snpdet file produced by poolfstat)
- get_SNP_position_in_genome.py -- Convert SNP positions called in one reference genome to approximate position in another genome based on blast results
- vcf2genobaypass.R -- R commands to generate the read count file from the VarScan VCF using *poolfstat*

#### demography_analysis --


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
- [poolfstat v1.1.1, v2.1.1](https://cran.r-project.org/web/packages/poolfstat/poolfstat.pdf)

## Other software used in the manuscript


## Data
SNPs and allele counts derived from the Pool-Seq data are available in the [**data**](data) directory, along with environmental data. Please see the README file within for information.

Please contact the authors for questions or issues.
