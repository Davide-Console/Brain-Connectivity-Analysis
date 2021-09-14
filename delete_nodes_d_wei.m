function [sol_matrix, sol_indexes, d_sol, error]=delete_nodes_d_wei(MC, n, d_ref, indexes, set_variation)

% inizializzazione elementi
new_matrix=zeros(n-1);
sol_matrix=zeros(n-1);
d_sol=Inf;
error = Inf;
sol_indexes = indexes;

for i=1:n
    
    % creazione di matrice ottenuta eliminando il nodo i-esimo
    x=1;
    y=1;
    for a=1:n
        for b=1:n
            if a~=i && b~=i
                new_matrix(x, y)=MC(a, b);
                y=y+1;
            end
        end
        y=1;
        if i~=a
        x=x+1;
        end
    end
    
    new_d_vector = strengths_und(new_matrix);
    new_d = mean(new_d_vector);
    
    % se l'errore è inferiore al 10% e migliore al precedente, salvo
    % la matrice, la sua small-worldness
    if (abs(d_ref-new_d))/d_ref<set_variation && abs(new_d-d_ref)<abs(d_sol-d_ref)
        error = (abs(d_ref-new_d))/d_ref;
        d_sol=new_d;
        sol_matrix=new_matrix;
        
        % indici per tener traccia di quali nodi sono stati collassati
        for p=1:n
            if p<i
                sol_indexes(p)=indexes(p);
            elseif p>i && p<=n
                sol_indexes(p-1)=indexes(p);
            elseif p==n
                sol_indexes(p)='0';
            end
        end
    end
end
end
