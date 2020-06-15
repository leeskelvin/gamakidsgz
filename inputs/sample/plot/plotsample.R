#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)

# data
dat = readRDS("master-trim.rds")

# definitions
cols = c("#edcdb1","#7fcdbb","#2c7fb8")
samp = dat[,"Z_TONRY"] >= 0.002 & (dat[,"Z_TONRY"] <= 0.15 | dat[,"Zfof"] <= 0.15) & (dat[,"NQ"] >= 3 | dat[,"NQ2_FLAG"] >= 1) & dat[,"SURVEY_CLASS"] >= 1

# dev
cairo_pdf(file="sample-log1pztonry.pdf", width=5, height=5)
par("mar"=c(4,4,1,1))

# plot
xlim = c(0,0.175)
step = 0.01
suppressWarnings(hist(log10(1+dat[,"Z_TONRY"]), breaks=c(-1000,seq(xlim[1],xlim[2]+2*step,by=step),1000), xlim=xlim, freq=TRUE, right=FALSE, col=cols[3], border=NA, main="", axes=FALSE, xlab=bquote(paste("redshift: ", z["Tonry"])), ylab="frequency", mgp=c(2.5,0.5,0)))
suppressWarnings(hist(log10(1+dat[samp,"Z_TONRY"]), breaks=c(-1000,seq(xlim[1],xlim[2]+2*step,by=step),1000), xlim=xlim, freq=TRUE, right=FALSE, col=cols[2], border=NA, add=TRUE))
abline(v=seq(xlim[1],xlim[2]+2*step,by=step), col="white")
legend("topleft", legend=c("GAMA II main", "GAMA-KiDS sample"), fill=cols[c(3,2)], bty="n", border=NA)
lab = seq(-0.1,0.7,by=0.05)
at = log10(1+lab)
axis(side=1, tcl=0.25, at=at[seq(1,length(lab),by=2)], lab=lab[seq(1,length(lab),by=2)], mgp=c(2.5,0.5,0))
axis(side=1, tcl=0.25, at=at[seq(0,length(lab),by=2)], lab=FALSE, tcl=0.125, mgp=c(2.5,0.5,0))
axis(side=3, tcl=0.25, at=at, lab=FALSE, tcl=0.25, mgp=c(2.5,0.5,0))
aaxis(side=2, tcl=0.25)
aaxis(side=4, tcl=0.25, labels=FALSE)

## plot
#xlim = c(0,0.6)
#step = 0.025
#suppressWarnings(hist(dat[,"Z_TONRY"], breaks=c(-1000,seq(xlim[1],xlim[2]+2*step,by=step),1000), xlim=xlim, freq=TRUE, right=FALSE, col=cols[3], border=NA, main="", axes=FALSE, xlab=bquote(paste("redshift: ", z["Tonry"])), ylab="frequency", mgp=c(2.5,0.5,0)))
#suppressWarnings(hist(dat[samp,"Z_TONRY"], breaks=c(-1000,seq(xlim[1],xlim[2]+2*step,by=step),1000), xlim=xlim, freq=TRUE, right=FALSE, col=cols[2], border=NA, add=TRUE))
#abline(v=seq(xlim[1],xlim[2]+2*step,by=step), col="white")
#legend("topright", legend=c("GAMA II main", "GAMA-KiDS sample"), fill=cols[c(3,2)], bty="n", border=NA)
#aaxis(side=1, nmin=3, tcl=0.25)
#aaxis(side=2, tcl=0.25)
#aaxis(side=3, tcl=0.25, labels=FALSE)
#aaxis(side=4, tcl=0.25, labels=FALSE)

# finish up
graphics.off()





