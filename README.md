# Brain-Connectivity-Analysis

## GENERAL INFORMATION
This is a brute force algorithm that enables the user to analyze a connectivity matrix extrapolated by fMRI.
The algorithm has three functions:
* it lines up all nodes from the most significant to the least one; the centrality is determined by the following equation:       
  centrality_j = local_degree_j/max(local_degree) + local_betweenness_j/max(local_betweenness)
* it reduces the order of the matrix mantaining a maximum variation of global degree OR small-worldness choose by the user by summing or deleting nodes;
* the user can see which nodes of the original matrix have been summed up (if sum of nodes) or which nodes are left (if deletion of nodes)

## REQUIREMENTS
The needed libraries are the following:

* Statistics and Machine Learning Toolbox (version 12.0)
* Brain Connectivity Toolbox (version 1.1.1.0)

Also the following function can be useful to create a synthetic matrix:
* WattsStrogatz.m

## INPUTS
At first the user must choose some settings:
* tell if there is a dataset <y/n>. If <y\>, specify it by inserting the file path; if <n\>, generate one using WattsStrogatz algorithm by specifying number of nodes, number of edges and rewire probability;
* choose weather the dataset must be weighted or binarized <b/w>. If <b\>, set a threshold value; if <w\>, the abolute values of the dataset's elements are used;
* choose the reference parameter between degree and small-worldness <d/s>. If <d\>, the parameter will be the degree; if <s\>, the parameter will be the small-worldness;
* choose the modality of reduction <c/d>. If <c\>, two nodes will be summed up for each iteration; if <d\>, the least significant node will be deleted;
* set the maximum variation, which must be a number set between 0 and 1.

## DATASET
The dataset must be a connectivity matrix with elements calculated using Pearson's linear correlation. All the values must be set between -1 and 1 and the main diagonal must be set to 1.
If the user does not have a real dataset extrapolated by MR, they can use the function WattsStrogatz.m to create a random connectivity matrix. A probability of rewiring set between 0.5 and 0.75 is suggested.

## OUTPUTS
The algorithm will show the user:
* the original connectivity matrix;
* the new reduced connectivity matrix;
* an array containing the name of all the nodes from the most significant to the least;
* an array containing the nodes' communities generated using the collapse method

## OTHER INFORMATION
The algorithm has been created with the AAL atlas in mind (90 nodes) and the function NODEtoREGION.m can be used only with this particular atlas. If other atlases are used, make sure to modify this function in order to be able to use it for the parcellation of interest. To achieve this, it is enough to modify lines 5, 16, 34 and 56.
