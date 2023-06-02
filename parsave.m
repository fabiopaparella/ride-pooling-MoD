function parsave(jj,ii,file)
    sol4_LC_temp =file;
    save(strcat('SF/L4/MatL4_',num2str(jj),'_',num2str(ii),'.mat'),'sol4_LC_temp')%, '-v7.3')
end

