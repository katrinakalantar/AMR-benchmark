# AMR-benchmark
Scripts to support AMR tool benchmarking study

### Current Active Scripts

**run-select-final.sh** is the pipeline runner script that calls the individual pipeline components from within `run-rgi`.

**run-rgi/** directory contains the prototype scripts used to run the various components of the CARD RGI-based pipeline for mNGS and WGS data with species-calling.

**notebooks/** directory contains the jupyter notebooks that were used to process the outputs of the CARD RGI-based pipeline and generate combined tables for UXR.

### Scripts for prior benchmarking / exploration efforts

**run-tools** contains scripts to run each individual tool and a wrapper to run all the tools given input files. These files are currently dependent on a particular set-up directory structure and will be difficult to run automatically. 