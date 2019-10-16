# This is the bioinformatics mid-semester project for Schwarz and Onken

# Create file with all hsp70gene_...fasta sequences and create a file with all the sequences
cat ./ref_sequences/hsp70gene_*.fasta > ./ref_sequences/allhsp70.fasta

# Do same thing with mcrAgene_...fasta
cat ./ref_sequences/mcrAgene_*.fasta > ./ref_sequences/allmcrA.fasta

# Run both of these new files through muscle to create a sequence alignment
~/Private/functions/muscle -in ./ref_sequences/allhsp70.fasta -out ./ref_sequences/hsp70aligned.fasta
~/Private/functions/muscle -in ./ref_sequences/allmcrA.fasta -out ./ref_sequences/mcrAaligned.fasta  

# Generate HMM files for both of the aligned sequence files utilizing hmmbuild
~/Private/functions/hmmer-3.2.1/bin/hmmbuild ./hsp70hmm.fasta ./ref_sequences/hsp70aligned.fasta
~/Private/functions/hmmer-3.2.1/bin/hmmbuild ./mcrAhmm.fasta ./ref_sequences/mcrAaligned.fasta  
