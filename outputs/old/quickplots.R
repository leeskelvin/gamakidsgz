#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)
require("RColorBrewer", quietly=TRUE)

# definitions
#dat = read.fitstab("2017-05-14_galaxy_zoo_gama09.fits")
#saveRDS(dat, file="2017-05-14_galaxy_zoo_gama09.rds")
dat = readRDS("2017-05-14_galaxy_zoo_gama09.rds")

# Bamford 2009 Figure 1
total = as.numeric(dat[,"shape_total"])
smooth = as.numeric(dat[,"shape_smooth"])
features = as.numeric(dat[,"shape_features"])
starartifact = as.numeric(dat[,"shape_star_or_artifact"])
psmooth = smooth/total
pfeatures = features/total
pstarartifact = starartifact/total
cataid = as.numeric(dat[,"gama_cataid"])
gamadat = gama.tiling(cataid)
z = as.numeric(gamadat[,"Z"])
binlo = seq(0,0.14,by=0.01)
binhi = seq(0.01,0.15,by=0.01)
zbin = binlo + 0.005
fsmooth = ffeatures = fstarartifact = funclassified = numeric(length(binlo))
thresh = 0.5
pch = 16
lwd = 2
for(i in 1:length(binlo)){
    samp = which(z >= binlo[i] & z < binhi[i])
    fsmooth[i] = length(which(psmooth[samp] > thresh)) / length(samp)
    ffeatures[i] = length(which(pfeatures[samp] > thresh)) / length(samp)
    fstarartifact[i] = length(which(pstarartifact[samp] > thresh)) / length(samp)
    funclassified[i] = 1 - (fsmooth[i] + ffeatures[i] + fstarartifact[i])
}
png(file="GAMABamford09Fig1.png", width=5, height=5, units="in", res=300)
par("mar"=c(4,4,1,1))
aplot(NA, xlab="Redshift", ylab="fraction", xlim=c(0,0.15), ylim=c(0,1))
legend("topleft", legend=c("smooth", "features", "star/artifact", "unclassified"), col=c("red", "blue", "green3", "orange"), bty="n", lty=1, pch=pch, lwd=lwd, inset=0.01)
points(zbin, fsmooth, type="b", col="red", pch=pch, lwd=lwd)
points(zbin, ffeatures, type="b", col="blue", pch=pch, lwd=lwd)
points(zbin, fstarartifact, type="b", col="green3", pch=pch, lwd=lwd)
points(zbin, funclassified, type="b", col="orange", pch=pch, lwd=lwd)
graphics.off()

# number of classifiers
num = as.numeric(dat[,"shape_total"])
#res = table(num)
n0014 = length(which(num >= 0 & num <= 14))
n1519 = length(which(num >= 15 & num <= 19))
n2024 = length(which(num >= 20 & num <= 24))
n2529 = length(which(num >= 25 & num <= 29))
n3034 = length(which(num >= 30 & num <= 34))
n3539 = length(which(num >= 35 & num <= 39))
n40 = length(which(num == 40))
n40p = length(which(num > 40))
cols = rev(brewer.pal(name="Set2", n=8))
png(file="GAMAusers.png", width=5, height=5, units="in", res=300)
par("mar"=c(1,1,1,1))
pie(c(n0014, n1519, n2024, n2529, n3034, n3539, n40, n40p), labels=c("0 - 14", "15 - 19", "20 - 24", "25 - 29", "30 - 34", "35 - 39", "40", ">40"), col=cols, border="white")
graphics.off()

# Simmons 2014 Fig 6
shapetotal = as.numeric(dat[,"shape_total"])
shapefeatures = as.numeric(dat[,"shape_features"])
edgetotal = as.numeric(dat[,"disk_total"])
edgeno = as.numeric(dat[,"disk_no"])
samp = which((shapefeatures/shapetotal) > 0.5 & (edgeno/edgetotal) > 0.5)
total = as.numeric(dat[,"bar_total"])[samp]
barred = as.numeric(dat[,"bar_bar"])[samp]
unbarred = as.numeric(dat[,"bar_no_bar"])[samp]
pbarred = barred/total
punbarred = unbarred/total
cataid = as.numeric(dat[,"gama_cataid"])[samp]
gamadat = gama.tiling(cataid)
z = as.numeric(gamadat[,"Z"])
binlo = seq(0,0.14,by=0.01)
binhi = seq(0.01,0.15,by=0.01)
zbin = binlo + 0.005
fbarred = numeric(length(binlo))
thresh = 0.5
pch = 16
lwd = 2
for(i in 1:length(binlo)){
    samp = which(z >= binlo[i] & z < binhi[i])
    fbarred[i] = length(which(pbarred[samp] > thresh)) / length(samp)
}
png(file="GAMASimmons14Fig6.png", width=5, height=5, units="in", res=300)
par("mar"=c(4,4,1,1))
aplot(NA, xlab="Redshift", ylab="fraction", xlim=c(0,0.15), ylim=c(0,1))
legend("topleft", legend=c("barred"), col=c("grey50"), bty="n", lty=1, pch=pch, lwd=lwd, inset=0.01)
points(zbin, fbarred, type="b", col="grey50", pch=pch, lwd=lwd)
graphics.off()

