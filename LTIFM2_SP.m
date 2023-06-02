function [sol] = LTIFM2_SP(jj1,ii1,jj2,ii2,solPart)

sol1.obj = 0;%solPart{jj1,ii1}.obj + solPart{jj2,ii2}.obj;  difference wrt no rp 
sol1.order= [1 1 2 2];
sol1.Delay = [0,0];%solPart{jj1,ii1}.obj;
%sol1.Delay2 = 0;%solPart{jj2,ii2}.obj;
%sol1.Dem = solPart{jj1,ii1}.Dem + solPart{jj2,ii2}.Dem;

sol2.obj = solPart{jj1,jj2}.obj + solPart{jj2,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj1,ii1}.obj - solPart{jj2,ii2}.obj;
sol2.order= [1 2 1 2];
sol2.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,ii1}.obj - solPart{jj1,ii1}.obj,...
              solPart{jj2,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj];
%sol2.Delay2 = [solPart{jj2,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj];
%sol2.Dem = solPart{jj1,jj2}.Dem + solPart{jj2,ii1}.Dem + solPart{ii1,ii2}.Dem;

sol3.obj = solPart{jj1,jj2}.obj + solPart{jj2,ii2}.obj + solPart{ii2,ii1}.obj - solPart{jj1,ii1}.obj - solPart{jj2,ii2}.obj;
sol3.order=[1 2 2 1];;
sol3.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,ii2}.obj + solPart{ii2,ii1}.obj - solPart{jj1,ii1}.obj,...
              0];
%sol3.Delay2 = [0];
%sol3.Dem = solPart{jj1,jj2}.Dem + solPart{jj2,ii2}.Dem + solPart{ii2,ii1}.Dem;

if sol2.obj < 0
sol = [sol2.obj sol2.Delay jj1 ii1 jj2 ii2 sol2.order];
elseif  sol3.obj < 0
sol = [sol3.obj sol3.Delay jj1 ii1 jj2 ii2 sol3.order];
else
sol = [sol1.obj sol1.Delay jj1 ii1 jj2 ii2 sol1.order ];
end

end

