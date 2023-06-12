%% NYCX to graphs.mat
clear all
clc

load('Compression/NYC4.mat')
N_edg = size(G_edges,1);
Old = load('Graphs.mat')

Tran = str2num(G_nodenames) + 1;
N_nod = length(Tran);
DemandS = zeros(N_nod,N_nod);
for ii = 1 : 357
    for jj = 1 : 357 % old nodes
        if Old.DemandS(ii,jj)~= 0
            ii1 = find(Tran==G_parent(ii));
            jj1 = find(Tran==G_parent(jj));
            if ii1 ~=jj1
            DemandS(ii1,jj1) = DemandS(ii1,jj1) + Old.DemandS(ii,jj);
            end
        end
    end
end
Edg1 = [];
Edg2 = [];
for ii = 1 : N_edg
Edg1(ii) = find(Tran==G_edges(ii,1)+1);
Edg2(ii) = find(Tran==G_edges(ii,2)+1);
end
Edg1 = Edg1';
Edg2 = Edg2';
Edg = [Edg1,Edg2];
Weight  = G_edges(:,3)/60;
G_road= digraph([Edg1;Edg2],[Edg2;Edg1],[Weight;Weight]);
NodesLoc = Old.NodesLoc(G_parent',:);
NodesLoc = NodesLoc(Tran,:);
save('Graphs107.mat', 'G_road','DemandS','NodesLoc');