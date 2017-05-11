# NGS-Analysis

Set of bioinformatics tools within docker containers to allow portability and use on any platform capable of running docker.  Primary purpose of these tools has been to identify SNPs in illumina sequencing data.


1. fastqc

      Used to run a quick check on sequencing quality
    
2. fastx 

      FastX_Barcode_Splitter sorts massive fastq files into smaller files based on barcode sequence

      FastX_trimmer trims barcode off sequence

3. sickle 
  
      Used to trim/remove reads based on quality and length

4. samtoolsbwa
  
      Contains both BWA and SAM tools to allow scripting to pass results from BWA directly into SAM tools
	
      Allows the generation of indices for reference sequence
	
      Aligns all reads to reference sequence  
  
      Converst sam files to bam files
  
      Sorts the alignments
  
      Used to index the bam files after read groups have been added.
     
5. picard
  
      Used to normalize the reference fasta file if needed
  
      Used to add read groups which are needed with GATK

6. gatk3.6
  
      Used to identify sequence variants

  Used to begin filtering the identified variants
      
Varscan not tested
samtools and bwa are also separate if want to change process.
