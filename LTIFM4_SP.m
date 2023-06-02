function [sol] = LTIFM4_SP(jj1,ii1,jj2,ii2,jj3,ii3,jj4,ii4,solPart)
objNP = solPart{jj1,ii1}.obj + solPart{jj2,ii2}.obj + solPart{jj3,ii3}.obj + solPart{jj4,ii4}.obj;
CommonObj =  - objNP + solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj;

sol1234.obj = 0;  %diff with no ridepooling
sol1234.order= [1 1 2 2 3 3 4 4];
sol1234.Delay = [0,0,0,0];% TimeOD1 = solPart{jj1,ii1}.obj;

sol12341234.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii3}.obj + solPart{ii3,ii4}.obj;
sol12341234.order = [1 2 3 4 1 2 3 4];
sol12341234.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii3}.obj + solPart{ii3,ii4}.obj- solPart{jj4,ii4}.obj];

sol12341243.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii4}.obj + solPart{ii4,ii3}.obj;
sol12341243.order = [1 2 3 4 1 2 4 3];
sol12341243.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii4}.obj + solPart{ii4,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii2}.obj + solPart{ii2,ii4}.obj - solPart{jj4,ii4}.obj];


sol12341324.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii2}.obj + solPart{ii2,ii4}.obj;
sol12341324.order= [1 2 3 4 1 3 2 4];
sol12341324.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii2}.obj + solPart{ii2,ii4}.obj - solPart{jj4,ii4}.obj];


sol12341342.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii4}.obj + solPart{ii4,ii2}.obj;
sol12341342.order=[1 2 3 4 1 3 4 2];
sol12341342.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii4}.obj + solPart{ii4,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii3}.obj + solPart{ii3,ii4}.obj - solPart{jj4,ii4}.obj];

sol12341423.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii2}.obj + solPart{ii2,ii3}.obj;
sol12341423.order=[1 2 3 4 1 4 2 3];
sol12341423.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii2}.obj + solPart{ii2,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj - solPart{jj4,ii4}.obj];
                 
sol12341432.obj = CommonObj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii3}.obj + solPart{ii3,ii2}.obj;
sol12341432.order=[1 2 3 4 1 4 3 2];
sol12341432.Delay = [solPart{jj1,jj2}.obj + solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj - solPart{jj1,ii1}.obj,...
                     solPart{jj2,jj3}.obj + solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii3}.obj + solPart{ii3,ii2}.obj - solPart{jj2,ii2}.obj,...
                     solPart{jj3,jj4}.obj + solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj + solPart{ii4,ii3}.obj - solPart{jj3,ii3}.obj,...
                     solPart{jj4,ii1}.obj + solPart{ii1,ii4}.obj - solPart{jj4,ii4}.obj];



Part = [sol1234.obj sol12341234.obj sol12341243.obj sol12341324.obj...
        sol12341342.obj sol12341423.obj sol12341432.obj];
vec = [sol1234 sol12341234 sol12341243 sol12341324...
        sol12341342 sol12341423 sol12341432];
[aa,bb]=min(Part);


if bb==1
sol = [sol1234.obj sol1234.Delay jj1 ii1 jj2 ii2 jj3 ii3 jj4 ii4 sol1234.order];
else
sol = [vec(bb).obj vec(bb).Delay jj1 ii1 jj2 ii2 jj3 ii3 jj4 ii4 vec(bb).order];
end

end

