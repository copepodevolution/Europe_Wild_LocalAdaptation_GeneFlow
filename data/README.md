## Data Description

### environmentaldata
**environmentaldata_surfacesalinity** and **environmentaldata_surfacetemperature** contain sea surface salinity (SSS) and sea surface temperature (SST) data used as input for BayPass analyses.
SSS and SST measurements were obtained at each sampling location using a CTD when each sample was collected.

The data columns are in the following order:

| Sample ID | Description |
| --- | --- |
| BB1E | Bothnian Bay, Station CVI |
| BB2E | Bothnian Bay, Station F2 |
| GBE | Gulf of Bothnia, Station F15 |
| HF1E | Tvärminne Field Station, University of Helsinki, Tvärminne Storfjärden, Finland |
| HF2E | Tvärminne Field Station, University of Helsinki, Tvärminne Storfjärden, Finland, technical replicate |
| IJE | IJsselmeer, Netherlands |
| KIE | Kiel, Germany |
| MME | Markermeer, Netherlands |
| RG1E | Gulf of Riga, Site 1 |
| RG2E | Gulf of Riga, Site 2 |
| SCE | Western Scheldt, Belgium |
| STE | Stockholm, Sweden |

### wild.snps and wild.snpdet

**wild.snps_freq** and **wild.snps_cov** contains SNP frequencies and coverages for every SNP in every wild population, generated using R::*poolfstat* and *baypass2freqs_cov.py*.
**wild.snps_freq** contains folded SNP frequencies -- the frequency shown for each SNP in each population is the frequency of the minor allele in that population.

The data columns are in the following order:

| Sample ID | Description |
| --- | --- |
| BB1E | Bothnian Bay, Station CVI |
| BB2E | Bothnian Bay, Station F2 |
| GBE | Gulf of Bothnia, Station F15 |
| HF1E | Tvärminne Field Station, University of Helsinki, Tvärminne Storfjärden, Finland |
| HF2E | Tvärminne Field Station, University of Helsinki, Tvärminne Storfjärden, Finland, technical replicate |
| IJE | IJsselmeer, Netherlands |
| KIE | Kiel, Germany |
| MME | Markermeer, Netherlands |
| RG1E | Gulf of Riga, Site 1 |
| RG2E | Gulf of Riga, Site 2 |
| SCE | Western Scheldt, Belgium |
| STE | Stockholm, Sweden |

**wild.snpdet** contains the reference scaffold and position for every SNP in the SNP frequency and coverage files
