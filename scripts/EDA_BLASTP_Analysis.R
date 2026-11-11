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
# DATE: October 2026
# VERSION: 1.0
#
# SCRIPT NAME: EDA_BLASTP_Analysis.R
#
# DESCRIPTION:
# Comparative analysis of ectodysplasin-A (EDA) protein
# sequences from human, mouse, rat and chicken.
#
# This script supports protein sequence analysis,
# processing of BLASTP results and visualisation
# of sequence similarity across species.
#
# SOFTWARE AND TOOLS:
# R, NCBI BLAST+, rentrez, seqinr and ggplot2
#
# REFERENCE PROTEIN ACCESSIONS:
# Human:   NP_001390.1
# Mouse:   NP_034229.1
# Rat:     NP_001292172.1
# Chicken: NP_001409628.1
#
# PURPOSE:
# Individual report: 
# Critical Evaluation of BLAST for EDA Protein Sequence Analysis: Integration with R, Python and Linux-Based Tools
#
# ============================================================
# EDA Protein Sequence Analysis Using BLASTP and R
# MSc Bioinformatics and Genomic Medicine
#
# Input:  Linux BLASTP best-hit results
# Output: Sequence identity figure and processed results table
# ============================================================

# 1. Load required package
library(ggplot2)

# 2. Import BLASTP results
blast_results <- read.delim(
  "results/EDA_BLASTP_best_hits.tsv",
  header = FALSE
)

# 3. Assign column names
colnames(blast_results) <- c(
  "Query",
  "Subject",
  "Identity",
  "Alignment_Length",
  "Query_Coverage",
  "E_value",
  "Bit_Score"
)

# 4. Assign species using NCBI protein accession numbers
species_lookup <- c(
  "NP_001292172.1" = "Rattus norvegicus",
  "NP_034229.1" = "Mus musculus",
  "NP_001409628.1" = "Gallus gallus"
)

blast_results$Species <- unname(
  species_lookup[blast_results$Subject]
)

# 5. Check that all accessions were recognised
if (anyNA(blast_results$Species)) {
  stop("One or more accession numbers were not recognised.")
}

# 6. Arrange species in the desired order
blast_results$Species <- factor(
  blast_results$Species,
  levels = c(
    "Rattus norvegicus",
    "Mus musculus",
    "Gallus gallus"
  )
)

# 7. Display the results
print(blast_results)

# 8. Generate the sequence identity chart
p <- ggplot(
  blast_results,
  aes(x = Species, y = Identity, fill = Species)
) +
  geom_col(width = 0.65) +
  geom_text(
    aes(label = sprintf("%.2f%%", Identity)),
    vjust = -0.5,
    size = 4.5
  ) +
  scale_y_continuous(
    limits = c(0, 105),
    breaks = seq(0, 100, 20)
  ) +
  labs(
    title = "Amino Acid Sequence Identity of EDA Orthologues",
    subtitle = "Relative to human EDA (NP_001390.1)",
    x = "Species",
    y = "Amino Acid Sequence Identity (%)"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(face = "italic", size = 11),
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 12),
    panel.grid.major.x = element_blank()
  )

# 9. Save the figure
ggsave(
  filename = "results/EDA_Sequence_Identity_Final.png",
  plot = p,
  width = 9,
  height = 5.5,
  dpi = 300
)

# 10. Export processed results
write.csv(
  blast_results,
  file = "results/EDA_BLASTP_Processed_Results.csv",
  row.names = FALSE
)

# 11. Record software versions for reproducibility
sink("results/R_Session_Info.txt")
sessionInfo()
sink()

# 12. Confirm successful execution
cat("EDA BLASTP analysis completed successfully.\n")
