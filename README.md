# Brain-Connectivity-Analysis

## GENERAL INFORMATION
This is a brute force algorithm that enables the user to analyze a connectivity matrix extrapolated by MRI.
The algorithm has three functions:
* it lines up all nodes from the most relevant to the least one; the centrality is determined by the following equation:           
  centrality_j = local_degree_j/max(local_degree) + local_betweenness_j/max(local_betweenness)
* it reduces the order of the matrix mantaining a variation of 10% of global degree OR small-worldness;
* for each node of the reduced matrix, the user can see witch nodes of the original matrix have been summed up.

## REQUIREMENTS
The needed libraries are the following:

* Statistics and Machine Learning Toolbox (version 12.0)

These functions from Brain Connectivity Toolbox are also needed:

* betweenness_bin.m
* betweenness_wei.m
* charpath.m
* clustering_coef_bu.m
* clustering_coef_wu.m
* degrees_und.m
* distance_bin.m
* distance_wei.m
* makerandCIJ_und.m
* strengths_und.m
* weight_conversion.m

Also the following function can be useful 
* WattsStrogatz.m

## DATASET
If the user does not have a real dataset extrapolated by MR, they can use the function WattsStrogatz.m to create a random connectivity matrix. I suggest a probability of rewiring set between 0.5 and 0.75.

## OTHER INFORMATION
The algorithm has been created with the AAL atlas in mind (90 nodes) and the function NODEtoREGION.m can be used only with this particular atlas. If other atlases are used, make sure to modify this function in order to be able to use it for the parcellation of interest.
