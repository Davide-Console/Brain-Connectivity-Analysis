function output=sw(matrix, n, k)

%Input: matrix=matrice random di connettività
%        n=ordine matrice
%Output: C=Clustering Index
%        PL=Path Length Index

% calcolo path length
matrix_length = distance_bin(matrix);
path_length = charpath(matrix_length);

% calcolo clustering
clustering_vector = clustering_coef_bu(matrix);

clustering_coeff = mean(clustering_vector);
%% calcolo smallworldness matrice small world
matrix_rnd = makerandCIJ_und(n, k);
%[graph_rnd, t_rnd]= WattsStrogatz(n, k/n, 1);
%matrix_rnd=make_matrix_smallworld(t_rnd);
% path length
matrix_rnd_length = distance_bin(matrix_rnd);
path_length_rnd= charpath(matrix_rnd_length);

path_length_normalized = path_length/path_length_rnd;

%clustering
clustering_vector_rnd = clustering_coef_bu(matrix_rnd);
clustering_coeff_rnd = mean(clustering_vector_rnd);

clustering_coeff_normalized = clustering_coeff/clustering_coeff_rnd;

%small world
output = clustering_coeff_normalized/path_length_normalized;
end