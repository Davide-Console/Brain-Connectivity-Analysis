function [h, t] = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) ritorna un grafico del modello di Watts-Strogatz model con
% nodi, N*K target, grado medio del nodo 2*K, e ricablaggio con probabilità beta.
%
% beta = 0 è un reticolo di anello, beta = 1 è un grafico random.

% connessine del nodo con i k nodi vicini. costruione dell'indice di un
% reticolo di anello
s = repelem((1:N)',1,K);
%repelem ripete l'elemento 
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;
%mode calcola il resto di funzioni trigonometriche

% ricablaggio dei nodi con probabilità beta
for source=1:N    
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end
h = graph(s,t);
end

