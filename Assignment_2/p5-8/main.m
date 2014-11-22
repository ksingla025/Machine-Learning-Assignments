function [mm,sm,mp,sp] = main(k,rep,init,PCA,FDA,imname)

    [d,l] = genData();

    if PCA
        projComps = pca(d);
        projComps = projComps(:,1:9);
        data = d*projComps;
        labels = l;
    end

    if FDA
        projComps = fda();
        data = d*projComps;
        labels = l;
    end

    if ~PCA && ~FDA
        [data,ind] = datasample(d,10000);
        labels = l(ind);
        projComps = [];
    end

    if init
        initMeans = ffp(data,k);
    else
        initMeans = [];
    end

    [mm,sm,mp,sp] = calcKmeans(data,labels,k,rep,init,initMeans,projComps,...
                                imname);

end