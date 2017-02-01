# Visibility_LA5C_data
The repo contains the code necessary to reproduce the analyses that we did on this dataset

https://openfmri.org/dataset/ds000030/

the Visibility code is found on danielemarinazzo/Visibility

The Shen278.mat file contains the Shen Parcellation and the attribution to Yeo's networks

The results_LA5c.mat file contains the results and other variables:

Age
FWD (framewise displacement)
Gender
Group (1=healthy, 2=SCHZ, 3=Bipolar, 4=ADHD)
mean_MI = average mutual information for each of the YEO RSNs
Sez
sizeROI = size (in numer of Shen parcels) of each YEO RSN

statistical tests were conducted with the mancovan package http://mialab.mrn.org/software/mancovan/

e.g.

[ T, p, FANCOVAN, pANCOVAN, stats ] = mancovan(mean_MI(:,5), Group,[Age FWD])

the violin plots are done with Cyril Pernet's package

http://neurostatscyrilpernet.blogspot.be/2016/08/show-me-data.html
https://github.com/CPernet/Robust_Statistical_Toolbox

The KS factors are computed using the code by Guillaume Rousselet

https://github.com/GRousselet/matlab_stats
