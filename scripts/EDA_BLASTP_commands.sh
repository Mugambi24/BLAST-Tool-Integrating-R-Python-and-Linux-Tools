#!/usr/bin/env bash

# ============================================================
# ASTON UNIVERSITY
# MSc Bioinformatics and Genomic Medicine
#
# Author: Mugambi Isaiah Alois
# Project: EDA Protein Sequence Analysis
# Date: 30th October 2026
#
# Description:
# Construction of a local EDA protein BLAST database
# and comparison against the human EDA query sequence.
#
# ============================================================

set -euo pipefail

# Step 1: Build protein database
makeblastdb \
  -in database/validated/EDA_subjects.faa \
  -dbtype prot \
  -parse_seqids \
  -out database/validated/EDA_db

# Step 2: Perform BLASTP analysis
blastp \
  -query sequences/human_EDA_R.faa \
  -db database/validated/EDA_db \
  -task blastp \
  -max_hsps 1 \
  -out results/EDA_BLASTP_validated.tsv \
  -outfmt "6 qseqid sseqid pident length qcovs evalue bitscore" \
  -num_threads 2
