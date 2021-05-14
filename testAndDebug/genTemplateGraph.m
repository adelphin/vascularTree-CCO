function G = genTemplateGraph(N, X, Y, Z)

G = graph;

% N = 7;
% X = 100;
% Y = 100;
% Z = 300;

warning('off')
% Generate N-1 successive nodes
for i = 1:N-1    
    G = addnode(G, ['n', num2str(i)]);
    G.Nodes.Coord{i} = createRandCoord([X,Y,Z/N]);
    G.Nodes.Coord{i}(3) = G.Nodes.Coord{i}(3) + (i-1)*Z/N;
end

% Generate a Nth node for a new branch
G = addnode(G, ['n', num2str(i+1)]);
G.Nodes.Coord{N} = createRandCoord([X,Y, Z/N]);
G.Nodes.Coord{N}(3) = G.Nodes.Coord{i}(3) + (N-1)*Z/N;

% create edges between N-1 successive nodes
for i = 1:N-2
    G = addVascEdge(G, ['n', num2str(i)], ['n', num2str(i+1)]);
end

%% branch a new node
G = addnode(G, ['n', num2str(N+1)]);
G.Nodes.Coord{N+1} = createRandCoord([X,Y, Z/N]);
G.Nodes.Coord{N+1}(3) = G.Nodes.Coord{i}(3) + (N-1)*Z/N;

lastEdge = ['n', num2str(N-2), '-n', num2str(N-1)];
G = branchNode(G, lastEdge, ['n', num2str(N)]);
end