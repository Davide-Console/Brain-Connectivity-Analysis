dataset_ex = '.';
while dataset_ex ~= 'y' && dataset_ex ~= 'n'
    dataset_ex = input('Do you have a dataset? <y/n> ', 's');
end
if dataset_ex == 'y'
    path = input("Insert the dataset's file path\n", 's');
    matrix = readmatrix(path);
elseif dataset_ex == 'n'
    fprintf('You will use WattsStrogatz Algorithm:\n');
    n = input('Select number of nodes: ');
    k = 1;
    while rem(k, n) ~= 0
        k = input('Select number of edges: ');
    end
    beta = input('Select rewire probability: ');
    [graph_sw, t] = WattsStrogatz(n, k/n, beta);
    plot(graph_sw);
    matrix = make_matrix_smallworld(t);
end

dataset_type = '.';
if dataset_ex == 'n'
    dataset_type = 'b';
end
while dataset_type ~= 'b' && dataset_type ~= 'w'
    dataset_type=input('The dataset must be studied in binary or weighted form? <b/w> ', 's');
end
if dataset_type == 'b'
    if dataset_ex == 'y'
        threshold_value=input('Set the threshold value: ');
        matrix = threshold(matrix, threshold_value);
        n = size(matrix, 1);
        I = eye(n);
        matrix = matrix - I;
    end
elseif dataset_type == 'w'
    matrix = abs(matrix);
end

dataset_ref = '.';
while dataset_ref ~= 'd' && dataset_ref ~= 's'
    dataset_ref=input('Which reference parameter do you want to use? <d/s> ', 's');
end

dataset_mod = '.';
while dataset_mod ~= 'c' && dataset_mod ~= 'd'
    dataset_mod=input('Do you want to collapse or delete nodes? <c/d> ', 's');
end

%% 1
if (dataset_ex == 'y' && dataset_type == 'b' && dataset_ref == 'd' && dataset_mod == 'c') || (dataset_ex == 'n' && dataset_ref =='d' && dataset_mod == 'c')

    N = n;
    k = nnz(matrix)/2;

    % reference degree
    d_ref_vector = degrees_und(matrix);
    d_ref = mean(d_ref_vector);
    fprintf("Il coefficiente di degree è: %f\n", d_ref);

    % hubs' analysis
    local_betweenness = betweenness_bin(matrix);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = degrees_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:);

    % variables
    new_matrix_d=matrix;
    x=n;
    d_vector=[d_ref];
    error_d_vector = [0];
    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");
    indexes_d = indexes;

    % degree check
    n=N;
    x=n;
    for i = 1:x
        matrix_prec = new_matrix_d;

        [new_matrix_d, indexes_d, d, error_d] = collapse_nodes_d(new_matrix_d, n, d_ref, indexes_d);

        if nnz(new_matrix_d) == 0
            new_matrix_d = matrix_prec;
            break;
        end

        n = n-1;
        d_vector = [d_vector d];
        error_d_vector = [error_d_vector error_d];
    end
    indexes_d = indexes_d(1:n);
    edges_d = n;

    vector_edges = [N:-1:edges_d];

    figure,
    plot(vector_edges, d_vector,'b', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento Degree');

    %controllo matrice ridotta con degree
    test = 0;
    hubs_str_d = hubs_descend(1:edges_d, 1)';
    hubs_str_d = string(".") + string(hubs_str_d)+ string(".");
    count_d = zeros(edges_d, 1);
    for i = 1:edges_d
        for j = 1:edges_d
            test = contains(indexes_d(i), hubs_str_d(j));
            count_d(i) = count_d(i)+test;
        end
    end
    
    regions_array_d=NODEtoREGION(indexes_d);
    
end

%% 2
if (dataset_ex == 'y' && dataset_type == 'b' && dataset_ref == 'd' && dataset_mod == 'd') || (dataset_ex == 'n' && dataset_ref =='d' && dataset_mod == 'd')

    N = n;
    k = nnz(matrix)/2;

    % reference degree
    d_ref_vector = degrees_und(matrix);
    d_ref = mean(d_ref_vector);
    fprintf("Il coefficiente di degree è: %f\n", d_ref);

    % hubs' analysis
    local_betweenness = betweenness_bin(matrix);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = degrees_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:);

    % variables
    new_matrix_d=matrix;
    x=n;
    d_vector=[d_ref];
    error_d_vector = [0];
    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");
    indexes_d = indexes;

    % degree check
    n=N;
    x=n;
    for i = 1:x
        matrix_prec = new_matrix_d;

        [new_matrix_d, indexes_d, d, error_d] = delete_nodes_d(new_matrix_d, n, d_ref, indexes_d);

        if nnz(new_matrix_d) == 0
            new_matrix_d = matrix_prec;
            break;
        end

        n = n-1;
        d_vector = [d_vector d];
        error_d_vector = [error_d_vector error_d];
    end
    indexes_d = indexes_d(1:n);
    edges_d = n;

    vector_edges = [N:-1:edges_d];

    figure,
    plot(vector_edges, d_vector,'b', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento Degree');

    test = 0;
    hubs_str_d = hubs_descend(1:edges_d, 1)';
    hubs_str_d = string(".") + string(hubs_str_d)+ string(".");
    count_d = zeros(edges_d, 1);
    for i = 1:edges_d
        for j = 1:edges_d
            test = contains(indexes_d(i), hubs_str_d(j));
            count_d(i) = count_d(i)+test;
        end
    end
    
    regions_array_d=NODEtoREGION(indexes_d);
   
end

%% 3
if (dataset_ex == 'y' && dataset_type == 'b' && dataset_ref =='s' && dataset_mod == 'c') || (dataset_ex == 'n' && dataset_ref =='s' && dataset_mod == 'c')
    
    N = n;
    k = nnz(matrix)/2;

    % reference smallworldness
    sw_ref = sw(matrix, n, k);
    fprintf("Il coefficiente di small worldness è: %f\n", sw_ref);

    % hubs' analysis
    local_betweenness = betweenness_bin(matrix);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = degrees_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:);

    % variables
    new_matrix_sw=matrix;
    x=n;
    sw_vector = [sw_ref];
    error_sw_vector = [0];
    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");
    indexes_sw = indexes;

    % small worldness check
    for i = 1:x
        matrix_prec = new_matrix_sw;

        [new_matrix_sw, indexes_sw, smallworldness, error_sw] = collapse_nodes_sw(new_matrix_sw, n, sw_ref, indexes_sw);

        if nnz(new_matrix_sw) == 0
            new_matrix_sw = matrix_prec;
            break;
        end

        n = n-1;
        sw_vector = [sw_vector smallworldness];
        error_sw_vector = [error_sw_vector error_sw];
    end
    indexes_sw = indexes_sw(1:n);
    edges_sw = n;  

    vector_edges = [N:-1:edges_sw];

    test = 0
    hubs_str_sw = hubs_descend(1:edges_sw, 1)';
    hubs_str_sw = string(".") + string(hubs_str_sw) + string(".");
    count_sw = zeros(edges_sw, 1);
    for i = 1:edges_sw
        for j = 1:edges_sw
            test = contains(indexes_sw(i), hubs_str_sw(j));
            count_sw(i) = count_sw(i)+test;
        end
    end

    figure,
    plot(vector_edges, sw_vector,'r', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento SmallWorldness');

    regions_array_d=NODEtoREGION(indexes_d);
    
end

%% 4
if (dataset_ex == 'y' && dataset_type == 'b' && dataset_ref =='s' && dataset_mod == 'd') || (dataset_ex == 'n' && dataset_ref =='s' && dataset_mod == 'd')
    
    N = n;
    k = nnz(matrix)/2;

    % reference smallworldness
    sw_ref = sw(matrix, n, k);
    fprintf("Il coefficiente di small worldness è: %f\n", sw_ref);

    % hubs' analysis
    local_betweenness = betweenness_bin(matrix);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = degrees_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:);

    % variables
    new_matrix_sw=matrix;
    x=n;
    sw_vector = [sw_ref];
    error_sw_vector = [0];
    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");
    indexes_sw = indexes;

    % small worldness check
    for i = 1:x
        matrix_prec = new_matrix_sw;

        [new_matrix_sw, indexes_sw, smallworldness, error_sw] = delete_nodes_sw(new_matrix_sw, n, sw_ref, indexes_sw);

        if nnz(new_matrix_sw) == 0
            new_matrix_sw = matrix_prec;
            break;
        end

        n = n-1;
        sw_vector = [sw_vector smallworldness];
        error_sw_vector = [error_sw_vector error_sw];
    end
    indexes_sw = indexes_sw(1:n);
    edges_sw = n;  

    vector_edges = [N:-1:edges_sw];

    test = 0
    hubs_str_sw = hubs_descend(1:edges_sw, 1)';
    hubs_str_sw = string(".") + string(hubs_str_sw) + string(".");
    count_sw = zeros(edges_sw, 1);
    for i = 1:edges_sw
        for j = 1:edges_sw
            test = contains(indexes_sw(i), hubs_str_sw(j));
            count_sw(i) = count_sw(i)+test;
        end
    end

    figure,
    plot(vector_edges, sw_vector,'r', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento SmallWorldness');

    regions_array_sw=NODEtoREGION(indexes_sw);
    
end

%% 5
if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='d' && dataset_mod == 'c'

    n = size(matrix, 1);
    I = eye(n);
    matrix = matrix - I;

    N = n;
    k = nnz(matrix)/2;

    % reference degree
    d_ref_vector = strengths_und(matrix);
    d_ref = mean(d_ref_vector);
    fprintf("Il coefficiente di weighted degree è: %f\n", d_ref);

    % hubs' analysis
    matrix_len = weight_conversion(matrix, 'lengths');
    local_betweenness = betweenness_wei(matrix_len);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = strengths_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:)

    % variables
    new_matrix_d = matrix;
    x = n;
    d_vector = [d_ref];
    error_d_vector = [0];

    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");

    indexes_d = indexes;
    
    % weighted degree check
    n = N;
    x = n;
    for i = 1:x
        matrix_prec = new_matrix_d;

        [new_matrix_d, indexes_d, d, error_d] = collapse_nodes_d_wei(new_matrix_d, n, d_ref, indexes_d);

        if nnz(new_matrix_d) == 0
            new_matrix_d = matrix_prec;
            break;
        end

        n = n-1;
        d_vector = [d_vector d];
        error_d_vector = [error_d_vector error_d];
    end
    indexes_d = indexes_d(1:n);
    edges_d = n;

    vector_edges = [N:-1:edges_d];

    figure,
    plot(vector_edges, d_vector,'b', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento Degree');

    test = 0;
    hubs_str_d = hubs_descend(1:edges_d, 1)';
    hubs_str_d = string(".") + string(hubs_str_d)+ string(".");
    count_d = zeros(edges_d, 1);
    for i = 1:edges_d
        for j = 1:edges_d
            test = contains(indexes_d(i), hubs_str_d(j));
            count_d(i) = count_d(i)+test;
        end

end

%% 6
if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='d' && dataset_mod == 'd'
    
    n = size(matrix, 1);
    I = eye(n);
    matrix = matrix - I;

    N = n;
    k = nnz(matrix)/2;

    % reference degree
    d_ref_vector = strengths_und(matrix);
    d_ref = mean(d_ref_vector);
    fprintf("Il coefficiente di weighted degree è: %f\n", d_ref);

    % hubs' analysis
    matrix_len = weight_conversion(matrix, 'lengths');
    local_betweenness = betweenness_wei(matrix_len);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = strengths_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:)

    % variables
    new_matrix_d = matrix;
    x = n;
    d_vector = [d_ref];
    error_d_vector = [0];

    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");

    indexes_d = indexes;
    
    % weighted degree check
    n = N;
    x = n;
    for i = 1:x
        matrix_prec = new_matrix_d;

        [new_matrix_d, indexes_d, d, error_d] = delete_nodes_d(new_matrix_d, n, d_ref, indexes_d);

        if nnz(new_matrix_d) == 0
            new_matrix_d = matrix_prec;
            break;
        end

        n = n-1;
        d_vector = [d_vector d];
        error_d_vector = [error_d_vector error_d];
    end
    indexes_d = indexes_d(1:n);
    edges_d = n;

    vector_edges = [N:-1:edges_d];

    figure,
    plot(vector_edges, d_vector,'b', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento Degree');

    test = 0;
    hubs_str_d = hubs_descend(1:edges_d, 1)';
    hubs_str_d = string(".") + string(hubs_str_d)+ string(".");
    count_d = zeros(edges_d, 1);
    for i = 1:edges_d
        for j = 1:edges_d
            test = contains(indexes_d(i), hubs_str_d(j));
            count_d(i) = count_d(i)+test;
        end

end

%% 7
if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='s' && dataset_mod == 'c'
    n = size(matrix, 1);
    I = eye(n);
    matrix = matrix - I;

    N = n;
    k = nnz(matrix)/2;
    
    % small-worldness reference
    sw_ref = sw_wei(matrix, n, k);
    fprintf("Il coefficiente di small worldness è: %f\n", sw_ref);

    % hubs' analysis
    matrix_len = weight_conversion(matrix, 'lengths');
    local_betweenness = betweenness_wei(matrix_len);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = strengths_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:)

    % variables
    new_matrix_sw = matrix;
    x = n;
    sw_vector = [sw_ref];
    error_sw_vector = [0];

    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");

    indexes_sw = indexes;

    % small-worldness check
    for i = 1:x

        matrix_prec = new_matrix_sw;

        [new_matrix_sw, indexes_sw, smallworldness, error_sw] = collapse_nodes_sw_wei(new_matrix_sw, n, sw_ref, indexes_sw);

        if nnz(new_matrix_sw) == 0
            new_matrix_sw = matrix_prec;
            break;
        end

        n = n-1;
        sw_vector = [sw_vector smallworldness];
        error_sw_vector = [error_sw_vector error_sw];
    end
    indexes_sw = indexes_sw(1:n);
    edges_sw = n;  

    vector_edges = [N:-1:edges_sw];

    test = 0
    hubs_str_sw = hubs_descend(1:edges_sw, 1)';
    hubs_str_sw = string(".") + string(hubs_str_sw) + string(".");
    count_sw = zeros(edges_sw, 1);
    for i = 1:edges_sw
        for j = 1:edges_sw
            test = contains(indexes_sw(i), hubs_str_sw(j));
            count_sw(i) = count_sw(i)+test;
        end
    end

    figure,
    plot(vector_edges, sw_vector,'r', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento SmallWorldness');

end

%% 8
if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='s' && dataset_mod == 'd'
    n = size(matrix, 1);
    I = eye(n);
    matrix = matrix - I;

    N = n;
    k = nnz(matrix)/2;
    
    % small-worldness reference
    sw_ref = sw_wei(matrix, n, k);
    fprintf("Il coefficiente di small worldness è: %f\n", sw_ref);

    % hubs' analysis
    matrix_len = weight_conversion(matrix, 'lengths');
    local_betweenness = betweenness_wei(matrix_len);
    local_betweenness = local_betweenness ./ max(local_betweenness);

    local_degree = strengths_und(matrix);
    local_degree = (local_degree ./ max(local_degree))';

    hubsA = local_degree + local_betweenness;
    hubsB = [(1:n)', hubsA];
    [AS,IX] = sort(hubsA, 'descend');
    hubs_descend = hubsB(IX,:)

    % variables
    new_matrix_sw = matrix;
    x = n;
    sw_vector = [sw_ref];
    error_sw_vector = [0];

    A = [1:1:n]';
    indexes = string(A);
    indexes = string(".")+ indexes + string(".  ");

    indexes_sw = indexes;

    % small-worldness check
    for i = 1:x

        matrix_prec = new_matrix_sw;

        [new_matrix_sw, indexes_sw, smallworldness, error_sw] = delete_nodes_sw(new_matrix_sw, n, sw_ref, indexes_sw);

        if nnz(new_matrix_sw) == 0
            new_matrix_sw = matrix_prec;
            break;
        end

        n = n-1;
        sw_vector = [sw_vector smallworldness];
        error_sw_vector = [error_sw_vector error_sw];
    end
    indexes_sw = indexes_sw(1:n);
    edges_sw = n;  

    vector_edges = [N:-1:edges_sw];

    test = 0
    hubs_str_sw = hubs_descend(1:edges_sw, 1)';
    hubs_str_sw = string(".") + string(hubs_str_sw) + string(".");
    count_sw = zeros(edges_sw, 1);
    for i = 1:edges_sw
        for j = 1:edges_sw
            test = contains(indexes_sw(i), hubs_str_sw(j));
            count_sw(i) = count_sw(i)+test;
        end
    end

    figure,
    plot(vector_edges, sw_vector,'r', 'LineWidth', 2);
    set(gca, 'XDir','reverse');
    title('Andamento SmallWorldness');

end