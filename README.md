# Brain-Connectivity-Analysis

## GENERAL INFORMATION
This is a brute force algorithm that enables the user to analyze a connectivity matrix extrapolated by MRI.
The algorithm has three functions:
* it lines up all nodes from the most relevant to the least one; the centrality is determined by the following equation:           
  centrality_j = local_degree_j/max(local_degree) + local_betweenness_j/max(local_betweenness)
* it reduces the order of the matrix mantaining a variation of 10% of global degree OR small-worldness by summing or deleting nodes;
* for each node of the reduced matrix, the user can see which nodes of the original matrix have been summed up (if sum of nodes) or which nodes are left (if deletion of nodes)

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

Also the following function can be useful to create a synthetic matrix:
* WattsStrogatz.m

## GUIDELINES
At first the user must choose some settings:
* tell if there is a dataset <y/n>. If <y\>, specify it by inserting the file path; if <n\>, generate one using WattsStrogatz algorithm by specifying number of nodes, number of edges and rewire probability.
* choose weather the dataset must be weighted or binarized <b/w>. If <b\>, set a threshold value; if <w\>, the abolute values of the dataset's elements are used.
* choose the reference parameter between degree and small-worldness <d/s>. If <d\>, the parameter will be the degree; if <s\>, the parameter will be the small-worldness.
* choose the modality of reduction <c/d>. If <c\>, two nodes will be summed up for each iteration; if <d\>, the least significant node will be deleted.

## DATASET
The dataset must be a connectivity matrix with elements calculated using Pearson's linear correlation. All the values must be set between -1 and 1 and the main diagonal must be set to 1.
If the user does not have a real dataset extrapolated by MR, they can use the function WattsStrogatz.m to create a random connectivity matrix. I suggest a probability of rewiring set between 0.5 and 0.75.

## OTHER INFORMATION
The algorithm has been created with the AAL atlas in mind (90 nodes) and the function NODEtoREGION.m can be used only with this particular atlas. If other atlases are used, make sure to modify this function in order to be able to use it for the parcellation of interest. To achieve this, it is enough to modify lines 5, 16, 34 and 56.
