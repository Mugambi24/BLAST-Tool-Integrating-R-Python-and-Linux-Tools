# ============================================================
# ASTON UNIVERSITY
# MSc Bioinformatics and Genomic Medicine
# Academic Year: 2026/2027
#
# PROJECT TITLE:
# Critical Evaluation of BLAST for EDA Protein Sequence
# Analysis: Integration with R, Python and Linux-Based Tools
#
# AUTHOR: Mugambi Isaiah Alois
# INSTITUTION: Aston University, Birmingham, UK
# DATE: 30th October 2026
# VERSION: 1.0
#
# SCRIPT NAME: EDA_sequence_validation.py
#
# DESCRIPTION:
# Validation of ectodysplasin-A (EDA) protein sequences
# using Python and Biopython.
#
# SPECIES:
# Homo sapiens
# Mus musculus
# Rattus norvegicus
# Gallus gallus
#
# REFERENCE ACCESSIONS:
# Human:   NP_001390.1
# Mouse:   NP_034229.1
# Rat:     NP_001292172.1
# Chicken: NP_001409628.1
#
# SOFTWARE:
# Python 3 and Biopython
#
# PURPOSE:
# Individual Report
#
# ============================================================
from Bio import SeqIO
from pathlib import Path
import csv

species = {
    "human": ("NP_001390.1", 391),
    "mouse": ("NP_034229.1", 391),
    "rat": ("NP_001292172.1", 391),
    "chicken": ("NP_001409628.1", 351)
}

valid_amino_acids = set("ACDEFGHIKLMNPQRSTVWY")

results = []

for name, (accession, expected_length) in species.items():

    file = Path(f"sequences/{name}_EDA_R.faa")

    record = SeqIO.read(file, "fasta")

    sequence = str(record.seq).upper()

    result = {
        "Species": name,
        "Accession": record.id,
        "Length_aa": len(sequence),
        "Expected_aa": expected_length,
        "Valid_Amino_Acids": set(sequence).issubset(valid_amino_acids),
        "Length_Matches": len(sequence) == expected_length,
        "Accession_Matches": record.id == accession
    }

    results.append(result)

output = Path("results/R_sequence_analysis/EDA_python_validation.csv")
output.parent.mkdir(parents=True, exist_ok=True)

with output.open("w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=results[0].keys())
    writer.writeheader()
    writer.writerows(results)

for result in results:
    print(result)
