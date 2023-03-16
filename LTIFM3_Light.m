function [sol] = LTIFM3(jj1,ii1,jj2,ii2)
load 'SF/Graphs.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
load ('solPart.mat');


sol5.obj = solPart{jj1,ii1}.obj + solPart{jj2,ii2}.obj;
sol5.order='No pooling';
sol5.TimeOD1 = solPart{jj1,ii1}.obj;
sol5.TimeOD2 = solPart{jj2,ii2}.obj;
sol5.Dem = solPart{jj1,ii1}.Dem + solPart{jj2,ii2}.Dem;

sol1.obj = solPart{jj1,jj2}.obj + solPart{jj2,ii1}.obj + solPart{ii1,ii2}.obj;
sol1.order='o1o2d1d2';
sol1.TimeOD1 = [solPart{jj1,jj2}.obj + solPart{jj2,ii1}.obj];
sol1.TimeOD2 = [solPart{jj2,ii1}.obj + solPart{ii1,ii2}.obj];
sol1.Dem = solPart{jj1,jj2}.Dem + solPart{jj2,ii1}.Dem + solPart{ii1,ii2}.Dem;

sol2.obj = solPart{jj1,jj2}.obj + solPart{jj2,ii2}.obj + solPart{ii2,ii1}.obj;
sol2.order='o1o2d2d1';
sol2.TimeOD1 = [ sol2.obj];
sol2.TimeOD2 = [solPart{jj2,ii2}.obj ];
sol2.Dem = solPart{jj1,jj2}.Dem + solPart{jj2,ii2}.Dem + solPart{ii2,ii1}.Dem;

sol3.obj = solPart{jj2,jj1}.obj + solPart{jj1,ii2}.obj + solPart{ii2,ii1}.obj;
sol3.order='o2o1d2d1';
sol3.TimeOD1 = [solPart{jj1,ii2}.obj + solPart{ii2,ii1}.obj ];
sol3.TimeOD2 = [solPart{jj2,jj1}.obj + solPart{jj1,ii2}.obj ];
sol3.Dem = solPart{jj2,jj1}.Dem + solPart{jj1,ii2}.Dem + solPart{ii2,ii1}.Dem;

sol4.obj = solPart{jj2,jj1}.obj + solPart{jj1,ii1}.obj + solPart{ii1,ii2}.obj;
sol4.order='o2o1d1d2';
sol4.TimeOD1 = [solPart{jj1,ii1}.obj ];
sol4.TimeOD2 = [sol4.obj];
sol4.Dem = solPart{jj2,jj1}.Dem + solPart{jj1,ii1}.Dem + solPart{ii1,ii2}.Dem;

Part = [sol5.obj sol1.obj sol2.obj sol3.obj sol4.obj];
[aa,bb]=min(Part);
if bb==1
sol = [sol5];
elseif bb==2
sol = [sol5 sol1];
elseif bb==3
sol = [sol5 sol2];
elseif bb==4
sol = [sol5 sol3];
elseif bb==5
sol = [sol5 sol4];
end

