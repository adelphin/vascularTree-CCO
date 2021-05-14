---
# vascularTree - Constrained Constructive Optimization (CCO) 

This repo contains code that aims at generating vascular trees following the work from Hamarneth *et al*. 2010 and Linninger *et al*. 2019

---

## Requirements

**This code was developed under Matlab2020a.** 

#### Toolboxes

**The following toolboxes are highly requested but not mandatory**. Indications are provided to run the code without them)

+ Optimization toolbox (Deactivate: In `treeGeneration.m`, use `flagParallel = 0;`. Tree volume will not be minimized) 
+ Parallel computing toolbox (Deactivate: In `treeGeneration.m`, use `flagParallel = 0;`. Generation will be slower)

#### Computational resources

The code was developped on a 32Gb ram computer with an Intel Core i7 8700K (6 cores).

The generation was not observed to require more than 15Gb of ram.

The volumetric rendering of the obtained graph however can be a problem. 

We used 200x200x200 matrices for rendering the volume. Going higher will require much more RAM.

---

## Basics

+ After adding the main directory and the sub-directories to your path, running `showGraph.m` will generate a very simple tree with N=5 terminal nodes in a 1.6mm-sided cube, the process should take less than a minute, even without the parallel toolbox.

+ The 2D projection from Matlab and the 3D volumetric rendering will be performed. If this last step fails, reduce the values of `X`, `Y` and `Z` parameters.

+ You can then increase N to generate more complicated trees.

---
