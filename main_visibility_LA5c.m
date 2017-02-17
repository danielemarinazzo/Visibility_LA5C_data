currdir=pwd;
addpath(pwd);
load('/yeo_RS7_278.mat') %Shen-Yeo parcels
maindir=''; %path to processed data
subs=dir([maindir 'sub*']);
for isub=1:length(subs);
    subdir=fullfile(maindir,subs(isub).name,'/fmri_rest/')
    cd(subdir)
    load data_ROI_278 %the time series for the 278 parcels, contained in the path defined above
    npoints=size(data_ROI,1);
    EO_YEO=zeros(9,npoints,npoints);MI=zeros(9,1);
    for iYeo=1:9 %loop over 9 RS networks
        indx=find(yeoROIs==iYeo);
        data_Yeo=data_ROI(:,indx);
        for nroi=1:length(indx)-1
            EO=zeros(npoints);
            [AD, K(:,nroi)]=Visibility(data_Yeo(:,nroi),2);
            %AD is the adjecency matrix
            %K is the degree
            EO=EO+AD;
        end
        EO_YEO(iYeo,:,:)=EO;
        MItot=zeros(size(K,2));
        for i=1:size(K,2)
            for j=i+1:size(K,2)
                MItot(i,j)=Mutual_information_visibility(K(:,i),K(:,j));
            end
        end
        K2=K;clear K
        MI(iYeo)=mean2(MItot);
    end
    save Vis_278_TOT EO_YEO MI;
    cd(currdir);
end