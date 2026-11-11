# EDA Protein Sequence Analysis Using BLASTP

**A comparative bioinformatics analysis of ectodysplasin-A (EDA) protein sequences using NCBI Web BLASTP, Linux BLAST+, R, and Python.**

## Overview

This project investigates protein sequence similarity between human ectodysplasin-A and selected vertebrate EDA sequences. It evaluates the use of BLASTP for identifying local protein similarities, compares the interactive NCBI Web BLASTP service with a reproducible local BLAST+ workflow, and uses R and Python to retrieve, validate, process, and visualise sequence data.

Pathogenic variants in **EDA** are associated with X-linked hypohidrotic ectodermal dysplasia (XLHED). Cross-species conservation can help prioritise regions for further investigation, but sequence similarity alone cannot establish protein function or the pathogenicity of an individual variant.

The analysis is educational and comparative; **no patient variants were analysed**.

## Objectives

- Retrieve accession-specific EDA protein sequences from NCBI RefSeq.
- Validate FASTA records, accession identifiers, sequence lengths, and amino-acid characters using R and Python.
- Compare human EDA with selected vertebrate sequences using NCBI Web BLASTP and Linux BLAST+.
- Evaluate percentage identity, query coverage, alignment length, E-values, and bit scores.
- Visualise comparative sequence identity using R and `ggplot2`.
- Critically assess the strengths, limitations, and reproducibility of BLASTP workflows.

## Reference protein sequences

| Species | Scientific name | NCBI RefSeq protein accession | Reported length |
|---|---|---|---:|
| Human | *Homo sapiens* | `NP_001390.1` | 391 aa |
| Mouse | *Mus musculus* | `NP_034229.1` | 391 aa |
| Rat | *Rattus norvegicus* | `NP_001292172.1` | 391 aa |
| Chicken | *Gallus gallus* | `NP_001409628.1` | 351 aa |

Human EDA (`NP_001390.1`) was used as the query; mouse, rat, and chicken sequences comprised the targeted local protein database.

## Methods

1. **Sequence retrieval.** NCBI RefSeq protein sequences were retrieved by accession using R and `rentrez` (reported version 1.2.4).
2. **Sequence validation.** `seqinr` in R and Biopython in Python were used to inspect protein lengths, residue characters, and accession identifiers. These checks supported processing integrity, not independent biological annotation accuracy.
3. **Web BLASTP.** The human EDA query was searched against a broader NCBI protein database to inspect vertebrate similarities.
4. **Linux BLAST+.** BLAST+ version **2.16.0** was run in Ubuntu under WSL. A custom protein database was built using `makeblastdb` from the three non-human FASTA records and queried using `blastp`.
5. **Reporting settings.** The local analysis used `-max_hsps 1` to report the highest-scoring segment pair per subject, and exported tabular results for further analysis.
6. **Visualisation.** R and `ggplot2` were used to compare percentage sequence identity between species.

## Results

The local BLASTP analysis reported the following alignments against human EDA:

| Subject | Identity | Alignment length | Query coverage | Bit score |
|---|---:|---:|---:|---:|
| Rat | 94.885% | 391 aa | 100% | 570 |
| Mouse | 94.629% | 391 aa | 100% | 569 |
| Chicken | 76.216% | 370 aa | 94% | 385 |

The rat and mouse comparisons were more similar to human EDA than the chicken comparison in this selected dataset. The local BLASTP chicken alignment had a reported E-value of **2.93 × 10⁻¹³⁷**. NCBI Web BLASTP reported approximately **5 × 10⁻¹²⁹** for chicken under different search conditions. E-values from different database sizes and parameter settings should not be compared without accounting for those differences.

**Parameter sensitivity:** A preliminary local analysis yielded two chicken alignments, including a weak secondary match (E-value 0.83). Restricting the output to one high-scoring segment per subject changed the reported chicken query coverage from 97% to 94%, but did not change the primary alignment identity, bit score, or E-value.

## Repository structure

```text
EDA_BLAST_Analysis/
├── database/       # Reference resources and local BLAST database inputs
├── documentation/  # Methodology, notes and supporting documentation
├── results/        # Alignment tables and visualisations
├── scripts/        # R, Python and command-line analysis workflows
├── sequences/      # Input EDA protein FASTA sequences
└── README.md       # Project overview
```

The folders above reflect the project organisation. **Consult the actual scripts and file names in this repository for runnable commands.** This README does not assert that any particular script name or results file exists.

## Software and tools

- **NCBI Web BLASTP** — interactive protein similarity searches
- **NCBI BLAST+ 2.16.0** — local `makeblastdb` and `blastp` analysis on Ubuntu/WSL
- **R:** `rentrez`, `seqinr`, `ggplot2` — retrieval, sequence checks, visualisation
- **Python:** Biopython — FASTA parsing and validation

To make the analysis fully reproducible, retain the exact FASTA input files, package versions, local database creation commands, BLAST parameter settings, and original result files. NCBI web database content can change over time.

## Interpretation and limitations

- BLASTP finds **local sequence similarities** using a heuristic seed-and-extend algorithm; distant similarities may be missed.
- Percentage identity and E-values must be interpreted together with alignment coverage, database composition, and biological context.
- The targeted local database contains only **three non-human sequences**, so it does not survey the full diversity of EDA homologues.
- Sequence conservation does **not** independently establish orthology, functional equivalence, or clinical pathogenicity.
- This study did **not** analyse patient-derived variants and cannot support variant-level clinical conclusions.

## Selected references

1. Altschul, S.F. *et al.* (1990). Basic local alignment search tool. *Journal of Molecular Biology*, 215(3), 403–410. https://doi.org/10.1016/S0022-2836(05)80360-2
2. Camacho, C. *et al.* (2009). BLAST+: architecture and applications. *BMC Bioinformatics*, 10, 421. https://doi.org/10.1186/1471-2105-10-421
3. Cock, P.J.A. *et al.* (2009). Biopython: freely available Python tools for computational molecular biology and bioinformatics. *Bioinformatics*, 25(11), 1422–1423. https://doi.org/10.1093/bioinformatics/btp163
4. Richards, S. *et al.* (2015). Standards and guidelines for the interpretation of sequence variants. *Genetics in Medicine*, 17(5), 405–424. https://doi.org/10.1038/gim.2015.30

## Author

**Mugambi Isaiah**  
Bioinformatics | Computational Genomics | Molecular Biology  
GitHub: [Mugambi24](https://github.com/Mugambi24)

## Disclaimer

This repository is intended for research and education only. It is not a validated clinical diagnostic workflow and should not be used as a standalone basis for clinical decisions.
