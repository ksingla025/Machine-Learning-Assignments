clear all;
close all;
clc;

fid = fopen('output2.txt','w+');

for k=5:5:25
    imname = strcat('random_all_',int2str(k));
    [mm,sm,mp,sp] = main(k,30,0,0,0,imname);

    fprintf(fid,'10000 randomly selected samples/random initialization/30 runs/%d clusters.\n\n',k);
    fprintf(fid,'Mean MSE:%f\n',mm);
    fprintf(fid,'STD MSE:%f\n',sm);
    fprintf(fid,'Mean Purity:%f\n',mp);
    fprintf(fid,'STD Purity:%f\n',sp);
    fprintf(fid,'------------------------------------------------------------------\n\n');

    imname = strcat('ffp_all_',int2str(k));
    [mm,~,mp,~] = main(k,1,1,0,0,imname);

    fprintf(fid,'10000 randomly selected samples/ffp initialization/1 run/%d clusters.\n\n',k);
    fprintf(fid,'MSE:%f\n',mm);
    fprintf(fid,'Purity:%f\n',mp);
    fprintf(fid,'------------------------------------------------------------------\n\n');

    imname = strcat('random_pca_',int2str(k));
    [mm,~,mp,~] = main(k,1,0,1,0,imname);

    fprintf(fid,'all samples/pca projection/random initialization/1 run/%d clusters.\n\n',k);
    fprintf(fid,'MSE:%f\n',mm);
    fprintf(fid,'Purity:%f\n',mp);
    fprintf(fid,'------------------------------------------------------------------\n\n');

    imname = strcat('ffp_pca_',int2str(k));
    [mm,~,mp,~] = main(k,1,1,1,0,imname);

    fprintf(fid,'all samples/pca projection/ffp initialization/1 run/%d clusters.\n\n',k);
    fprintf(fid,'MSE:%f\n',mm);
    fprintf(fid,'Purity:%f\n',mp);
    fprintf(fid,'------------------------------------------------------------------\n\n');

    imname = strcat('random_fda_',int2str(k));
    [mm,~,mp,~] = main(k,1,0,0,1,imname);

    fprintf(fid,'all samples/fda projection/random initialization/1 run/%d clusters.\n\n',k);
    fprintf(fid,'MSE:%f\n',mm);
    fprintf(fid,'Purity:%f\n',mp);
    fprintf(fid,'------------------------------------------------------------------\n\n');

    imname = strcat('ffp_fda_',int2str(k));
    [mm,~,mp,~] = main(k,1,1,0,1,imname);

    fprintf(fid,'all samples/fda projection/ffp initialization/1 run/%d clusters.\n\n',k);
    fprintf(fid,'MSE:%f\n',mm);
    fprintf(fid,'Purity:%f\n',mp);
    fprintf(fid,'------------------------------------------------------------------\n\n');
end

fclose(fid);




