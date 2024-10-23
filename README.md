# Using cfDNA fragmentation profiles for disease prediction
Background: Rather than using disease-specific genetic markers for cfDNA deconvolution, this work uses an alternative approach to determine cell-of-origin for cfDNA fragments based on a sample’s fragmentation profile. Nucleases most frequently cleave DNA at “linker regions” between nucleosomes (regions not wrapped around a nucleosome, but stretching between them). Because of this, cfDNA fragmentation can be used to infer nucleosome spacing and gene expression, and thereby rank the relative contribution of each cell type to a sample. This paper shows that fragmentation signatures can be used to train a predictive model that can then differentiate between matched case and control samples for several different conditions. This model also performs well using low-coverage datasets.

Hypothesis: Differential cell death due to neurodegeneration in ALS can be observed via fragmentation analysis and used as a predictor of disease state.

Methods:
- Calculate window protection scores and nucleosome positioning (peak calling algorithm)  
    - Specified by Snyder et al. 2016, using Shendure lab source code  
    - Validate that methylation cfDNA data agrees with expectations from WGS  
- Cell-of-origin analysis  
    - Compare to single-cell RNA sequencing expression levels summarized per gene
    - Aim to replicate the enrichment of skeletal muscle in cfDNA obtained from methylation estimates
    - Test for differences in cell type of origin between ALS cases and controls
    - Test for association with cell type proportions and ALS phenotypes
- Benchmark with other fragmentation-based cfDNA approaches
    - IchorDNA
    - Griffin
- Statistical analysis on fragmentation patterns and cell-of-origin inference
    - Train ML model for
        - Binary case control status
        - ALS phenotypes 
    - Compare integrating fragmentomic featurs with methylation, CpG coverage, and kmer approaches 

Questions:
- How does this work with our bisulfite-converted samples?
- How do the deconvolution results compare with our previous methylation work?
- Best combination of cfDNA epigenetic features to use as a classifier?
    - Goal is to squeeze as much information as we can from one dataset
- How can we infer information about biological gene expression from fragmentation profiles that we can’t from differential methylation?

Related work:
Snyder et al., 2016, Cell 164, 57–68 January 14, 2016 a2016 Elsevier Inc. http://dx.doi.org/10.1016/j.cell.2015.11.050  
Esfahani, M.S., Hamilton, E.G., Mehrmohamadi, M. et al. Inferring gene expression from cell-free DNA fragmentation profiles. Nat Biotechnol 40, 585–597 (2022). https://doi.org/10.1038/s41587-022-01222-4

