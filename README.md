# MWASHypertension

This project is an implementation of a pipeline for metagenomic analysis using hypertension as a case study.

## Samples
The samples used for the implementation were obtained from the study <em>Dysbiosis of gut microbiota contributes to the pathogenesis of hypertension</em>, these samples can be found in the following project in ENA: [PRJEB13870](https://www.ebi.ac.uk/ena/browser/view/PRJEB13870)


## Requirements

Here you can find the principal requirements to implement the used pipeline

Tool | Use |
:---: | :--- |
[Python](https://www.python.org/) | Language used for the generation of visualizations |
[R](https://www.r-project.org/) | Language used for reading the markdown file of the pipeline and the implementation of siamcat|
[Trim-galore](https://github.com/FelixKrueger/TrimGalore) | Quality control and filter |
[Superfocus](https://github.com/metageni/SUPER-FOCUS) | Funcitonal annotation |
[Kraken v.1](https://github.com/DerrickWood/kraken) | Taxonomic sequence classifier |
[Krona](https://github.com/marbl/Krona/wiki) | Interactive metagenomic visualization |
[Megahit](https://github.com/voutcn/megahit) | Metagenome assembly |
[STAMP](https://beikolab.cs.dal.ca/software/STAMP) | Analyze taxonomic profiles |
[Seaborn](https://seaborn.pydata.org/) | Graphics |
[SIAMCAT](https://siamcat.embl.de/index.html) | Implementation and generation of machine learning models |

## Results 
The main results can be found in the [results folder](results/)
