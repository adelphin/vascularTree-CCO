function G = renameGraph(G, prefix)

G.Nodes.Name = strrep(G.Nodes.Name, 'n', prefix);
G.Nodes.parentNode = strrep(G.Nodes.parentNode, 'n', prefix);
G.Nodes.childrenNodes = strrep(G.Nodes.childrenNodes, 'n', prefix);
G.Edges.Name = strrep(G.Edges.Name, 'n', prefix);
