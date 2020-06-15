#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)

# definitions
indir = "/gama/survey/kids/data/sci/"
#source("/gama/survey/kids/coverage/kids.coverage.R")
files = grep(".fits", dir(indir), v=T)
cols = c("FILE", "BAND", "FWHM")
results = matrix("", nrow=length(files), ncol=length(cols))
colnames(results) = cols

i = 1

# loop
for(i in 1:length(files)){
    
    counter(i, length(files))
    file = files[i]
    band = strsplit(strsplit(file, "_sci")[[1]][1], "")[[1]]
    band = band[length(band)]
    fwhm = as.numeric(read.fitskey("PSF_FWHM", file=paste(indir, "/", file, sep="")))
    results[i,] = c(file, band, fwhm)
    
}

# save
write.cat(results, file="seeing.csv")

# analysis plots
file = results[,"FWHM"]
band = results[,"BAND"]
fwhm = as.numeric(results[,"FWHM"]) # arcsec
ulim = formatC(quantile(fwhm[band=="u"], 0.8), format="f", digits=2)
glim = formatC(quantile(fwhm[band=="g"], 0.8), format="f", digits=2)
rlim = formatC(quantile(fwhm[band=="r"], 0.8), format="f", digits=2)
ilim = formatC(quantile(fwhm[band=="i"], 0.8), format="f", digits=2)
png(file="seeing.png", width=5, height=4, units="in", res=300)
par("mar"=c(4,4,1,1))
aplot(NA, xlim=c(0.5,1.3), ylim=c(0,4), xlab="FWHM / arcsec", ylab="Density")
col = hsv(seq(2/3,0,len=4))
lwd = 1.5
lines(density(fwhm[band=="u"], kernel="rect", bw=0.1/sqrt(12)), col=col[1], lwd=lwd)
lines(density(fwhm[band=="g"], kernel="rect", bw=0.1/sqrt(12)), col=col[2], lwd=lwd)
lines(density(fwhm[band=="r"], kernel="rect", bw=0.1/sqrt(12)), col=col[3], lwd=lwd)
lines(density(fwhm[band=="i"], kernel="rect", bw=0.1/sqrt(12)), col=col[4], lwd=lwd)
legend("topright", legend=c("u","g","r","i"), col=col, bty="n", lty=1, lwd=lwd, inset=0.04)
mtext(ulim, side=3, at=as.numeric(ulim), line=-1.2, cex=0.5, col=col[1])
mtext(glim, side=3, at=as.numeric(glim), line=-1.2, cex=0.5, col=col[2])
mtext(rlim, side=3, at=as.numeric(rlim), line=-1.2, cex=0.5, col=col[3])
mtext(ilim, side=3, at=as.numeric(ilim), line=-1.2, cex=0.5, col=col[4])
graphics.off()



