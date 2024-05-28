!/bin/bash

# 1. Create a directory for the project
mkdir rnaseq_project
cd rnaseq_project

# 2. Download and install Nextflow
wget -qO- https://get.nextflow.io | bash
chmod +x nextflow

# 3. Create a Nextflow script (e.g., rnaseq_pipeline.nf)
cat > rnaseq_pipeline.nf << EOF
#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.reads = "data/*_R{1,2}.fastq.gz"
params.outdir = "results"
params.genome_index = "HISAT2/grch38/genome"
params.gtf_file = "hg38/Homo_sapiens.GRCh38.106.gtf"

process fastqc {
    publishDir params.outdir, mode: 'copy'
    input:
        tuple val(sample), path(reads)
    output:
        tuple val(sample), path("${sample}_trimmed.fastq.gz")
    script:
        """
        fastqc ${reads} -o .
        java -jar trimmomatic-0.39.jar PE -threads 4 ${reads[0]} ${reads[1]} \
            ${sample}_trimmed_R1.fastq.gz ${sample}_unpaired_R1.fastq.gz \
            ${sample}_trimmed_R2.fastq.gz ${sample}_unpaired_R2.fastq.gz \
            TRAILING:10 -phred33
        fastqc ${sample}_trimmed_R1.fastq.gz -o .
        fastqc ${sample}_trimmed_R2.fastq.gz -o .
        cat ${sample}_trimmed_R1.fastq.gz ${sample}_trimmed_R2.fastq.gz > ${sample}_trimmed.fastq.gz
        """
}

process hisat2_alignment {
    publishDir params.outdir, mode: 'copy'
    input:
        tuple val(sample), path(reads)
    output:
        tuple val(sample), path("${sample}.bam")
    script:
        """
        hisat2 -q --rna-strandness RF -x ${params.genome_index} -U ${reads} | samtools sort -o ${sample}.bam
        echo "HISAT2 finished running!"
        """
}

process feature_counts {
    publishDir params.outdir, mode: 'copy'
    input:
        tuple val(sample), path(bam)
    output:
        tuple val(sample), path("${sample}.txt")
    script:
        """
        featureCounts -T 4 -S 2 -a ${params.gtf_file} -o ${sample}.txt ${bam}
        echo "featureCounts finished running!"
        """
}

workflow {
    Channel.fromFilePairs(params.reads) \
        | fastqc \
        | hisat2_alignment \
        | feature_counts
}

EOF