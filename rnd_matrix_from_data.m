function M = rnd_matrix_from_data(matrix)

%data una matrice pesata ne crea un altra con gli stessi elementi
%randomizzati e simmetrizzati con 0 sulla diagonale

% input: matrix   matrice di connettività pesata
% output: M   matrice di connettività pesata randomizzata

up_ind = find(triu(ones(size(matrix,1)),1)==1);  
up_length = length(up_ind);                 
up_elements = matrix(up_ind);
matrix(up_ind) = up_elements(randperm(up_length) );
t1=triu(matrix);
t2=tril(matrix');
M=t1+t2;
end