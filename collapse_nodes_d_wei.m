function [sol_matrix, sol_indexes, d_sol, error]=collapse_nodes_d_wei(MC, n, d_ref, indexes)

new_matrix=zeros(n-1);
sol_matrix=zeros(n-1);
d_sol=Inf;
error = Inf;
sol_indexes = indexes;

for i=1:n-1
    for j=i+1:n
        L=2;
        for k=1:n
            if k~=i && k~=j
                new_matrix(1, L) = (MC(i, k)+MC(j, k));   
                new_matrix(L, 1) = new_matrix(1, L);
                L=L+1;
            elseif k==i
                new_matrix(1, 1) = 0; %????????????????????
            end
        end
        
        x=2;
        y=2;
        for a=1:n
            for b=1:n
                if (a~=i && a~=j) && (b~=i && b~=j)
                    new_matrix(x, y) = MC(a, b);
                    y=y+1;
                end
            end
            if a~=i && a~=j
            x=x+1;
            end
            y=2;
        end
        
        new_d_vector = strengths_und(new_matrix);
        new_d = mean(new_d_vector);
        
        if (abs(d_ref-new_d))/d_ref<0.1 && abs(new_d-d_ref)<abs(d_sol-d_ref)
            error = (abs(d_ref-new_d))/d_ref;
            d_sol=new_d;
            sol_matrix=new_matrix;
            %indici
            sol_indexes = [strcat(indexes(i), indexes(j)); indexes];
            for p = i+1 : n
                sol_indexes (p) = sol_indexes (p+1);
            end
            sol_indexes (n+1) = "0"; 
            for r = j : n-1
                sol_indexes (r) = sol_indexes(r+1);
            end
            sol_indexes (n) = "0";  
        end
    end
end

end

