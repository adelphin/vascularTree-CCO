G = graph;

N = 10;
warning('off')
% Generate N-1 successive nodes
for i = 1:N-1    
    G = addnode(G, ['n', num2str(i)]);
    G.Nodes.Coord{i} = [rand(1,2), i];
end

% Generate a Nth node for a new branch
G = addnode(G, ['n', num2str(i+1)]);
G.Nodes.Coord{i+1} = [rand(1,2), N/2+1];

% create edges between N-1 successive nodes
for i = 1:N-2
    G = addVascEdge(G, ['n', num2str(i)], ['n', num2str(i+1)]);
end

% add new branch
G = addVascEdge(G, 'n2', ['n', num2str(N)]);
