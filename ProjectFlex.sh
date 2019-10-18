# This is the bioinformatics mid-semester project for Schwarz and Onken
# Usage: bash ProjectFlex.sh "path_to_muscle" " path_to_hmmbuild" "path_to_hmmsearch" "ref_sequences-path" "proteomes-path"

# Create file with all hsp70gene_...fasta sequences and create a file with all the sequences
cat "$4"/hsp70gene_*.fasta > "$4"/allhsp70.fasta

# Do same thing with mcrAgene_...fasta
cat "$4"/mcrAgene_*.fasta > "$4"/allmcrA.fasta

# Run both of these new files through muscle to create a sequence alignment
"$1" -in "$4"/allhsp70.fasta -out "$4"/hsp70aligned.fasta
"$1" -in "$4"/allmcrA.fasta -out "$4"/mcrAaligned.fasta  

# Generate HMM files for both of the aligned sequence files utilizing hmmbuild
"$2" ./hsp70hmm.fasta "$4"/hsp70aligned.fasta
"$2" ./mcrAhmm.fasta "$4"/mcrAaligned.fasta  

# For loop to run both the HMM files through each of the proteomes and place them in a master file called masterflex.txt
echo "proteome mcrA_genes hsp70_genes" > masterflex.txt
for file in "$5"/proteome_*.fasta
do
a=$(echo $file)
b=$("$3" ./mcrAhmm.fasta $file | grep ">>" | wc -l)
c=$("$3" ./hsp70hmm.fasta $file | grep ">>" | wc -l) 
echo "$a $b $c" >> masterflex.txt
done

# Generating a final file that lists the top 5 proteomes to continue with considering that the mcrA gene must be there
# We gave all the proteomes with at least one mcrA gene and at least one hsp70 gene
# The "most resistant" proteomes to pH are listed first
cat masterflex.txt | grep -E "[1-9] [1-9]" | sort -k 3 -n -r | cut -d ' ' -f 1 > bestproteomes.txt
