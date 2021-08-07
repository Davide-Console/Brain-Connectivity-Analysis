function matrix_smallworld = make_matrix_smallworld(t)

%prende il vettore t, output della funzione WattsStrogatz.m, contenente le
%informazioni sui legami e ritorna una matrice di connettività

n=length(t(:, 1));
k=length(t(1, :));
matrix_smallworld = zeros(n);

for i=1:n
    for j=1:k
        a=t(i, j);
        matrix_smallworld(i, a)=1;
        matrix_smallworld(a, i)=1;
    end
end

matrix_smallworld(1:1+size(matrix_smallworld,1):end) = 0;
end