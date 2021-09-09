function output=sw_wei(matrix, n, k)

%Input: matrix=matrice random di connettività
%        n=ordine matrice
%Output: C=Clustering Index
%        PL=Path Length Index

% calcolo path length
lengths_matrix = weight_conversion(matrix, 'lengths');
[distance_matrix,B] = distance_wei(lengths_matrix);
path_length = charpath(distance_matrix);

% calcolo clustering
clustering_vector = clustering_coef_wu(matrix);
clustering_coeff = mean(clustering_vector);

%% calcolo smallworldness matrice small world
matrix_rnd = rnd_matrix_from_data(matrix);

% path length matrice random
lengths_matrix_rnd = weight_conversion(matrix_rnd, 'lengths');
[distance_matrix_rnd,B] = distance_wei(lengths_matrix_rnd);
path_length_rnd = charpath(distance_matrix_rnd);

path_length_normalized = path_length/path_length_rnd;

%clustering matrice random
matrix_norm_rnd = matrix_rnd ./ max(matrix_rnd); 
clustering_vector_rnd = clustering_coef_wu(matrix_norm_rnd);
clustering_coeff_rnd = mean(clustering_vector_rnd);

clustering_coeff_normalized = clustering_coeff/clustering_coeff_rnd;

%small world
output = clustering_coeff_normalized/path_length_normalized;
end