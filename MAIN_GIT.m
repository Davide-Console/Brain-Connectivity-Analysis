dataset_ex = '.';
while dataset_ex ~= 'y' && dataset_ex ~= 'n'
    dataset_ex=input('Do you have a dataset? <y/n> ', 's');
end
if dataset_ex == 'y'
    path=input("Insert the dataset's file path\n", 's');
    matrix = readmatrix(path);
elseif dataset_ex == 'n'
    fprintf('You will use WattsStrogatz Algorithm:\n');
    n=input('Select number of nodes: ');
    k=input('Select average degree: ');
    beta=input('Select rewire probability: ');
end

dataset_type = '.';
if dataset_ex == 'n'
    dataset_type = 'b';
end
while dataset_type ~= 'b' && dataset_type ~= 'w'
    dataset_type=input('The dataset must be studied in binary or weighted form? <b/w> ', 's');
end

dataset_ref = '.';
while dataset_ref ~= 'd' && dataset_ref ~= 's'
    dataset_ref=input('Which reference parameter do you want to use? <d/s> ', 's');
end

if dataset_ex == 'y' && dataset_type == 'b' && dataset_ref =='d'
end

if dataset_ex == 'y' && dataset_type == 'b' && dataset_ref =='s'
end

if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='d'
end

if dataset_ex == 'y' && dataset_type == 'w' && dataset_ref =='s'
end

if dataset_ex == 'n' && dataset_ref =='d'
end

if dataset_ex == 'n' && dataset_ref =='s'
end