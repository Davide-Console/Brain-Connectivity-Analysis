function [sol_matrix, sol_indexes, sw_sol, error]=delete_nodes_sw_wei(MC, n, sw_ref, indexes)

% inizializzazione elementi
new_matrix=zeros(n-1);
sol_matrix=zeros(n-1);
sw_sol=Inf;
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
    
    n_edges=nnz(new_matrix)/2;
    new_sw = sw_wei(new_matrix, n-1, n_edges);
    
    % se l'errore è inferiore al 10% e migliore al precedente, salvo
    % la matrice, la sua small-worldness
    if (abs(sw_ref-new_sw))/sw_ref<0.10 && abs(new_sw-sw_ref)<abs(sw_sol-sw_ref)
        error = (abs(sw_ref-new_sw))/sw_ref;
        sw_sol=new_sw;
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
