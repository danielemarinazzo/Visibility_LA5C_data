% this code computes the partition distance and the Sorensen index among
% subnetworks for visibility adjacency graphs.

clear;clc;
load('vis_152_proc.mat') %load pair of visibility adjacency matrices from the LA5C dataset

Qa=0;
%partition according to Louvain algorithm
for j=1:100 %hundred runs for the Louvain algorithm
    [M,Q]=community_louvain(A1);
    if Q>Qa
        Qa=Q;
        Ma=M;
    end
end

%same thing for the other adjacency matrix
Qb=0;
for j=1:100
    [M,Q]=community_louvain(A2);
    if Q>Qb
        Qb=Q;
        Mb=M;
    end
end
%compute Sorensen's similarity index for each pair of clusters

na=max(Ma);
nb=max(Mb);

for i=1:na
    x=find(Ma==i);
    ta(i)=mean(x);
end

for i=1:nb
    y=find(Mb==i);
    tb(i)=mean(y);
end

[f inda]=sort(ta);

[f indb]=sort(tb);
for i=1:na
    for j=1:nb
        x=find(Ma==i);
        y=find(Mb==j);
        SOR(i,j)=2*length(intersect(x,y))/(length(x)+length(y));
    end
end
% compute partition distance
[V,MIpd] = partition_distance(Ma,Mb); 

figure(1);
subplot(2,2,1);plot(Ma,'o');set(gca,'FontSize',20);xlim([0 length(Ma)+1]);ylim([0.5 max(Ma)+1]);xlabel('time');ylabel('cluster')
subplot(2,2,3);plot(Mb,'o');set(gca,'FontSize',20);xlim([0 length(Mb)+1]);ylim([0.5 max(Mb)+1]);xlabel('time');ylabel('cluster')
subplot(2,2,[2 4]);imagesc(SOR(inda,indb));title(['pairwise Sorensen Index \n MI partition distance = ' num2str(MIpd)]);colorbar;colormap magma
%xlabel('series 1');ylabel('series 2');
set(gca,'FontSize',20)