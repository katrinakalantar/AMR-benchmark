#!/bin/bash

groot align -i grootCARDindex -f $1 $2 | groot report -c .1 > $3

