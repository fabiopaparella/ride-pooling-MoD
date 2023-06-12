%% Startup
clear; close all; clc

[G2, D2] = CreateGraph("NYC2.mat");
[G3, D3] = CreateGraph("NYC3.mat");
[G4, D4] = CreateGraph("NYC4.mat");
[G5, D5] = CreateGraph("NYC5.mat");

%% Function
function [G,D] = CreateGraph(filename)
    % Load everything
    load(filename, 'G_edges', 'G_nodenames', 'G_nodecoordX', 'G_nodecoordY', 'G_parent')
    MG_edges1 = G_edges(:,1)';
    MG_edges2 = G_edges(:,2)';
    MG_edgesW = G_edges(:,3)';
    MG_names  = cell(1,size(G_nodenames,1));
    MG_coords = [G_nodecoordX', G_nodecoordY'];

    % Convert nodename numbers to char
    MG_names_dbl = zeros(1,size(G_nodenames,1));
    for idx = 1:size(G_nodenames,1)
        MG_names{1,idx} = strtrim(string(G_nodenames(idx,:)));
        MG_names_dbl(1,idx) = double(MG_names{1,idx});
        MG_names{1,idx} = char(MG_names{1,idx});
    end

    % Get index of nodes
    for idx = 1:size(G_edges,1)
        MG_edges1(idx) = find(MG_names_dbl == MG_edges1(idx));
        MG_edges2(idx) = find(MG_names_dbl == MG_edges2(idx));
    end

    % Make tables for graph
    EdgeTable = table([MG_edges1', MG_edges2'], MG_edgesW', ...
                  'VariableNames', {'EndNodes', 'Weight'});
    NodeTable = table(MG_names', MG_coords, ...
                  'VariableNames', {'Name', 'Coordinates'});
    G = digraph(EdgeTable, NodeTable);

    % Convert demand matrix to new matrix D
    load('ride-pooling-MoD-master/NYC/Demm.mat', 'DemandS')
    D = zeros(size(G_nodenames,1));
    for row = 1:size(DemandS,1)
    for col = 1:size(DemandS,2)
        if DemandS(row, col) > 0
            d_row = find(MG_names_dbl == G_parent(row));
            d_col = find(MG_names_dbl == G_parent(col));
            D(d_row, d_col) = D(d_row, d_col) + DemandS(row, col);
        end
    end
    end
end