function [sol] = LTIFM3_SP(jj1,ii1,jj2,ii2,jj3,ii3,solPart)
objNP = solPart{jj1,ii1}.obj + solPart{jj2,ii2}.obj + solPart{jj3,ii3}.obj;

sol123.obj = 0;  %diff with no ridepooling
sol123.order= [1 1 2 2 3 3];
sol123.Delay = [0,0,0];% TimeOD1 = solPart{jj1,ii1}.obj;
%sol123.TimeOD2 = solPart{jj2,ii2}.obj;
%sol123.TimeOD3 = solPart{jj3,ii3}.obj;
%sol123.Dem = sparse(solPart{jj1,ii1}.Dem + solPart{jj2,ii2}.Dem + solPart{jj3,ii3}.Dem);

sol123123.obj = - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii3}.obj;
sol123123.order = [1 2 3 1 2 3];
sol123123.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123123.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii1}.Dem + solPart{ii1,ii2}.Dem + solPart{ii2,ii3}.Dem);

sol123132.obj = -objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii2}.obj;
sol123132.order= [1 2 3 1 3 2];
sol123132.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii1}.obj + solPart{ii1,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123132.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii1}.Dem + solPart{ii1,ii3}.Dem + solPart{ii3,ii2}.Dem);

sol123213.obj = - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj + solPart{ii2,ii1}.obj + solPart{ii1,ii3}.obj;
sol123213.order=[1 2 3 2 1 3];
sol123213.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj + solPart{ii2,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii2}.obj + solPart{ii2,ii1}.obj + solPart{ii1,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123213.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii2}.Dem + solPart{ii2,ii1}.Dem + solPart{ii1,ii3}.Dem);

sol123231.obj = - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj + solPart{ii2,ii3}.obj + solPart{ii3,ii1}.obj;
sol123231.order = [ 1 2 3 2 3 1];
sol123231.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj + solPart{ii2,ii3}.obj + solPart{ii3,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii2}.obj + solPart{ii2,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123231.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii2}.Dem + solPart{ii2,ii1}.Dem + solPart{ii1,ii3}.Dem);

sol123312.obj = - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii1}.obj + solPart{ii1,ii2}.obj;
sol123312.order = [1 2 3 3 1 2];
sol123312.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123312.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii3}.Dem + solPart{ii3,ii1}.Dem + solPart{ii1,ii2}.Dem);

sol123321.obj = - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii2}.obj + solPart{ii2,ii1}.obj;
sol123321.order = [1 2 3 3 2 1];
sol123321.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii2}.obj + solPart{ii2,ii1}.obj - solPart{jj1,ii1}.obj,...
                   solPart{jj2,jj3}.obj + solPart{jj3,ii3}.obj + solPart{ii3,ii2}.obj - solPart{jj2,ii2}.obj,...
                   solPart{jj3,ii3}.obj - solPart{jj3,ii3}.obj];
%sol123321.Dem = sparse(solPart{jj1,jj2}.Dem + solPart{jj2,jj3}.Dem + solPart{jj3,ii3}.Dem + solPart{ii3,ii2}.Dem + solPart{ii2,ii1}.Dem);

Part = [sol123.obj sol123123.obj sol123132.obj sol123213.obj sol123231.obj sol123312.obj sol123321.obj];
vec = [sol123 sol123123 sol123132 sol123213 sol123231 sol123312 sol123321];
[aa,bb]=min(Part);


if bb==1
sol = [sol123.obj sol123.Delay jj1 ii1 jj2 ii2 jj3 ii3 sol123.order];
else
sol = [vec(bb).obj vec(bb).Delay jj1 ii1 jj2 ii2 jj3 ii3 vec(bb).order];
end

end

