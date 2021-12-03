#!/bin/bash

rgi bwt -1 $1 -2 $2 -a bowtie2 -o $3 --clean --include_wildcard
