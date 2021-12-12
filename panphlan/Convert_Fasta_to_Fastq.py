from Bio import SeqIO

for r in SeqIO.parse("in.fa", "fasta"):
    r.letter_annotations["solexa_quality"] = [40] * len(r)
    print(r.format("fastq"), end='')