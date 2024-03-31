#!/bin/bash

#Running files in the current directory if you have files in different directories please do change the path of the files

# STEP 1: Runnig fastqc
fastqc SRR26924243.fastq -o 
fastqc SRR26924244.fastq -o 
fastqc SRR26924245.fastq -o 
fastqc SRR26924246.fastq -o 
fastqc SRR26924247.fastq -o 
fastqc SRR26924248.fastq -o 


# running trimmomatic to trim reads with poor quality
# Performing quality check using FastQC on the raw FASTQ file, this was done for all the six files
fastqc SRR26924243.fastq

# Trim reads using Trimmomatic
java -jar trimmomatic-0.39.jar SE -threads 4 SRR26924243.fastq SRR26924243_trimmed.fastq TRAILING:10 -phred33

# Run FastQC on the trimmed FASTQ file
fastqc SRR26924243_trimmed.fastq 


# STEP 2: Run HISAT2
# get the genome indices using the below link
# wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz


# run alignment
hisat2 -q --rna-strandness R -x HISAT2/grch38/genome -U SRR26924243_trimmed.fastq | samtools sort -o SRR26924243.bam
echo "HISAT2 finished running!"

# STEP 3: Run featureCounts - Quantification
# get gtf file using the below link
# wget http://ftp.ensembl.org/pub/release-106/gtf/homo_sapiens/Homo_sapiens.GRCh38.106.gtf.gz
featureCounts -S 2 -a ../hg38/Homo_sapiens.GRCh38.106.gtf -o SRR26924243.txt SRR26924243.bam
echo "featureCounts finished running!"





