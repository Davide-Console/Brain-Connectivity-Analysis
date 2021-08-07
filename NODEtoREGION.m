function regions_array = NODEtoREGION(nodes_array)

n = size(nodes_array, 1);
regions_array = strings(n, 1);
nodes = {'.1.' '.2.' '.3.' '.4.' '.5.' '.6.' '.7.' '.8.' '.9.' '.10.' 
    '.11.' '.12.' '.13.' '.14.' '.15.' '.16.' '.17.' '.18.' '.19.' '.20.' 
    '.21.' '.22.' '.23.' '.24.' '.25.' '.26.' '.27.' '.28.' '.29.' '.30.' 
    '.31.' '.32.' '.33.' '.34.' '.35.' '.36.' '.37.' '.38.' '.39.' '.40.' 
    '.41.' '.42.' '.43.' '.44.' '.45.' '.46.' '.47.' '.48.' '.49.' '.50.' 
    '.51.' '.52.' '.53.' '.54.' '.55.' '.56.' '.57.' '.58.' '.59.' '.60.' 
    '.61.' '.62.' '.63.' '.64.' '.65.' '.66.' '.67.' '.68.' '.69.' '.70.' 
    '.71.' '.72.' '.73.' '.74.' '.75.' '.76.' '.77.' '.78.' '.79.' '.80.' 
    '.81.' '.82.' '.83.' '.84.' '.85.' '.86.' '.87.' '.88.' '.89.' '.90.'};

%creazione dizionario dei nodi
keys = {'1', '2', '3', '4', '5', 
    '6', '7', '8', '9', '10', 
    '11', '12', '13', '14', '15', 
    '16', '17', '18', '19', '20', 
    '21', '22', '23', '24', '25', 
    '26', '27', '28', '29', '30', 
    '31', '32', '33', '34', '35', 
    '36', '37', '38', '39', '40', 
    '41', '42', '43', '44', '45', 
    '46', '47', '48', '49', '50', 
    '51', '52', '53' ,'54', '55', 
    '56', '57', '58', '59', '60', 
    '61', '62', '63', '64', '65', 
    '66', '67', '68', '69', '70', 
    '71', '72', '73', '74', '75', 
    '76', '77', '78', '79', '80', 
    '81', '82', '83', '84', '85', 
    '86', '87', '88', '89', '90'};
values = {'Precentral_L', 'Precentral_R', 'Frontal_Sup_L', 'Frontal_Sup_R', 'Frontal_Sup_Orb_L', 
    'Frontal_Sup_Orb_R', 'Frontal_Mid_L', 'Frontal_Mid_R', 'Frontal_Mid_Orb_L', 'Frontal_Mid_Orb_R', 
    'Frontal_Inf_Oper_L', 'Frontal_Inf_Oper_R', 'Frontal_Inf_Tri_L', 'Frontal_Inf_Tri_R', 'Frontal_Inf_Orb_L', 
    'Frontal_Inf_Orb_R', 'Rolandic_Oper_L', 'Rolandic_Oper_R', 'Supp_Motor_Area_L', 'Supp_Motor_Area_R', 
    'Olfactory_L', 'Olfactory_R', 'Frontal_Sup_Medial_L', 'Frontal_Sup_Medial_R', 'Frontal_Mid_Orb_L', 
    'Frontal_Mid_Orb_R', 'Rectus_L', 'Rectus_R', 'Insula_L', 'Insula_R', 
    'Cingulum_Ant_L', 'Cingulum_Ant_R', 'Cingulum_Mid_L', 'Cingulum_Mid_R', 'Cingulum_Post_L', 
    'Cingulum_Post_R', 'Hippocampus_L', 'Hippocampus_R', 'ParaHippocampal_L', 'ParaHippocampal_R', 
    'Amygdala_L', 'Amygdala_R', 'Calcarine_L', 'Calcarine_R', 'Cuneus_L', 
    'Cuneus_R', 'Lingual_L', 'Lingual_R', 'Occipital_Sup_L', 'Occipital_Sup_R', 
    'Occipital_Mid_L', 'Occipital_Mid_R', 'Occipital_Inf_L', 'Occipital_Inf_R', 'Fusiform_L', 
    'Fusiform_R', 'Postcentral_L', 'Postcentral_R', 'Parietal_Sup_L', 'Parietal_Sup_R', 
    'Parietal_Inf_L', 'Parietal_Inf_R', 'SupraMarginal_L', 'SupraMarginal_R', 'Angular_L', 
    'Angular_R', 'Precuneus_L', 'Precuneus_R', 'Paracentral_Lobule_L', 'Paracentral_Lobule_R', 
    'Caudate_L', 'Caudate_R', 'Putamen_L', 'Putamen_R', 'Pallidum_L', 
    'Pallidum_R', 'Thalamus_L', 'Thalamus_R', 'Heschl_L', 'Heschl_R', 
    'Temporal_Sup_L', 'Temporal_Sup_R', 'Temporal_Pole_Sup_L', 'Temporal_Pole_Sup_R', 'Temporal_Mid_L', 
    'Temporal_Mid_R', 'Temporal_Pole_Mid_L', 'Temporal_Pole_Mid_R', 'Temporal_Inf_L', 'Temporal_Inf_R'};
dictionary = containers.Map(keys, values);

% sostituisco il numero dei nodi collassati con i rispettivi nomi
for j = 1:n
    for i = 1:90
        
        test = contains(nodes_array(j), nodes(i));
        
        if test == 1
            a = nodes(i);
            b = strip(a, ".");
            regions_array(j) = strcat(regions_array(j), {' '}, dictionary(char(b)));
        end    
    end
end

end