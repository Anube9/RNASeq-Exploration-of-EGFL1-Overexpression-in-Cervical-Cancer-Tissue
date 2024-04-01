# RNASeq-Exploration-of-EGFL1-Overexpression-in-Cervical-Cancer-Tissue
 This project investigated gene expression changes associated with pre-cancer. RNA sequencing data was analyzed to identify genes differentially expressed between pre-cancerous and healthy samples

# Data Acquisition: 
RNA-seq analysis rests upon a dataset acquired from Sequence Read Archive (SRA) database. This dataset used in this project comprises raw RNA-seq paired reads originating from Homosapiens, specifically from the EGFL7 overexpression tissue. The dataset comprises 3 EGFL1 overexpression patients and 3 Negative controls from the SRA database with accession SRX22618098 - 103 using SRA Toolkit.

# Data Characteristics: 
**Sequencing Technology:** The data was generated usingIllumina HiSeq 2500, ensuring high-throughput and comprehensive coverage of the transcriptome.<br>

**Read Length and Coverage:** Sequencing reads have anaverage length of 150bp, and the dataset achieves robustcoverage across the entire transcriptome, providing a detailed snapshot of gene expression patterns.<br>

# Methodology: 
After obtaining the data from the SRA, the steps given in the below flowchart have been followed.<br>

<img src="https://github.com/Anube9/RNASeq-Exploration-of-EGFL1-Overexpression-in-Cervical-Cancer-Tissue/assets/112353734/9a041f06-0f30-4b69-9d60-7ea9944d0f34" width="350" height="350" alt="Image Description" class="center-image"><br>

**Quality Check:** First, the quality of the raw sequencing reads was assessed using a software called FastQC. This ensures the reads are reliable for further analysis.
**Read Trimming:** Next, low-quality regions at the beginning and end of the reads were removed using a tool called Trimmomatic. This improves the overall quality of the data.
**Alignment:** The trimmed reads were then aligned to a reference genome using HISAT2. This process maps the reads to specific locations on the reference genome, allowing us to understand where genes are located in the sequenced samples.
**Conversion of BAM to SAM:** The output from HISAT2 is typically in a format called BAM. In some cases, the data might be converted to a different format called SAM using Samtools. Both formats store the alignment information.
**Gene Expression Quantification:** Finally, a tool called featureCounts was used to quantify the expression level of each gene. This tells us how much of each gene is present in the samples. The output of this step is usually a matrix showing gene expression counts for each sample.

# Downstream analysis: 









