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

# For loop to run both the HMM files through each of the proteomes and place them in a master file
echo "proteome mcrA_genes hsp70_genes"
for file in ./proteomes/proteome_*.fasta
do
a=$(echo $file)
~/Private/functions/hmmer-3.2.1/bin/hmmsearch ./mcrAhmm.fasta $file | grep ">>" | wc -l >> masterflex.txt
echo "Amount of hsp70 matches:" >> masterflex.txt
~/Private/functions/hmmer-3.2.1/bin/hmmsearch ./hsp70hmm.fasta $file | grep ">>" | wc -l >> masterflex.txt 
echo "$a $b $c" >> masterflex.txt
done
