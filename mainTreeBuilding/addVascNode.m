function [G, nodeName] = addVascNode(G, coord, isTerm, name)
% Adds a new node to G with the proper properties
% By default, new nodes are terminal

if nargin <4 || isempty(name)
    nodeName = ['n', num2str(numnodes(G))];
else
    nodeName = name;
end

if nargin < 3
    isTerm = 1;
end

Name = {nodeName};
Coord{1} = coord;
parentNode= {''};
childrenNodes= {'', ''};
isTermNode = isTerm;

nodeProp = table(Name, Coord, parentNode, childrenNodes, isTermNode);
G = addnode(G, nodeProp);

end
