#!/bin/bash

groot align -i ./run-groot/grootCARDindex -f $1 $2 | groot report -c .1 > $3

