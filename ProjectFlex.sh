# This is the bioinformatics mid-semester project for Schwarz and Onken

# Create file with all hsp70gene_...fasta sequences and create a file with all the sequences
cat ./ref_sequences/hsp70gene_*.fasta > ./ref_sequences/allhsp70.fasta

# Do same thing with mcrAgene_...fasta
cat ./ref_sequences/mcrAgene_*.fasta > ./ref_sequences/allmcrA.fasta

# Run both of these new files through muscle
~/Private/functions/muscle -in ./ref_sequences/allhsp70.fasta -out ./ref_sequences/hsp70aligned.fasta
~/Private/functions/muscle -in ./ref_sequences/allmcrA.fasta -out ./ref_sequences/mcrAaligned.fasta  
