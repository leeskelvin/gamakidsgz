#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)

# definitions
dat = readRDS("../results/gama09_debiased.rds")

# data
samp = which(dat[,"absmag_r"] <= -19 & dat[,"Z_TONRY"] <= 0.1)
sub = dat[samp,]
#praw = sub[,"spiral_a_spiral_fraction"]
#pdebiased = sub[,"spiral_a_spiral_debiased"]
#pname = "spiral"
#praw = sub[,"shape_features_frac"]
#pdebiased = sub[,"shape_features_debiased"]
#pname = "features"
zlo1 = 0.02 #sort(sub[,"Z_TONRY"])[100]
zlo2 = 0.03 #sort(sub[,"Z_TONRY"])[100]
zhi1 = 0.09 #sort(sub[,"Z_TONRY"],decreasing=TRUE)[100]
zhi2 = 0.10 #sort(sub[,"Z_TONRY"],decreasing=TRUE)[100]
bw = 0.2

# column data
rfeatures = sub[,"shape_features_frac"]
dfeatures = sub[,"shape_features_debiased"]
rfaceon = sub[,"disk_no_fraction"]
dfaceon = sub[,"disk_no_debiased"]; dfaceon[dfaceon > 1] = -9999
rspiral = sub[,"spiral_a_spiral_fraction"]
dspiral = sub[,"spiral_a_spiral_debiased"]; dspiral[dspiral > 1] = -9999
rarms1 = sub[,"spiral_c_1_fraction"]
darms1 = sub[,"spiral_c_1_debiased"]; darms1[darms1 > 1] = -9999
rarms2 = sub[,"spiral_c_2_fraction"]
darms2 = sub[,"spiral_c_2_debiased"]; darms2[darms2 > 1] = -9999
rarms3 = sub[,"spiral_c_3_fraction"]
darms3 = sub[,"spiral_c_3_debiased"]; darms3[darms3 > 1] = -9999
rarms4 = sub[,"spiral_c_4_fraction"]
darms4 = sub[,"spiral_c_4_debiased"]; darms4[darms4 > 1] = -9999
rarmsm = sub[,"spiral_c_more_than_4_fraction"]
darmsm = sub[,"spiral_c_more_than_4_debiased"]; darmsm[darmsm > 1] = -9999





# FEATURES
png(file="votefrac_features.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Features", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2)
denrawlo = density(rfeatures[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rfeatures[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(dfeatures[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(dfeatures[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# FACE-ON
png(file="votefrac_faceon.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Face-On", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rfaceon[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rfaceon[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(dfaceon[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(dfaceon[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# SPIRAL
png(file="votefrac_spiral.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Spiral", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rspiral[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rspiral[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(dspiral[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(dspiral[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# ARMS 1
png(file="votefrac_arms1.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Arms 1", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon * dspiral
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rarms1[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rarms1[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(darms1[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(darms1[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# ARMS 1
png(file="votefrac_arms2.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Arms 2", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon * dspiral
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rarms2[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rarms2[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(darms2[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(darms2[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# ARMS 1
png(file="votefrac_arms3.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Arms 3", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon * dspiral
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rarms3[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rarms3[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(darms3[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(darms3[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# ARMS 1
png(file="votefrac_arms4.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Arms 4", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon * dspiral
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rarms4[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rarms4[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(darms4[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(darms4[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()





# ARMS 1
png(file="votefrac_armsm.png", width=6, height=6, units="in", res=150)
par("mar"=c(4,4,1,1))

# plot
#barplot(hist(praw[1:100])$count, col="white")
aplot(NA, log="y", xlim=c(0,1), ylim=c(0.01,10), axes=FALSE, main="", xlab="Arms 5+", ylab="normalised density", xaxs="i", yaxs="i")

# plot data
pabove = dfeatures * dfaceon * dspiral
zlosamp = which(sub[,"Z_TONRY"] > zlo1 & sub[,"Z_TONRY"] <= zlo2 & pabove > 0.5)
zhisamp = which(sub[,"Z_TONRY"] > zhi1 & sub[,"Z_TONRY"] <= zhi2 & pabove > 0.5)
denrawlo = density(rarmsm[zlosamp], kernel="rect", bw=bw/sqrt(12))
denrawhi = density(rarmsm[zhisamp], kernel="rect", bw=bw/sqrt(12))
dendeblo = density(darmsm[zlosamp], kernel="rect", bw=bw/sqrt(12))
dendebhi = density(darmsm[zhisamp], kernel="rect", bw=bw/sqrt(12))
polygon(x=c(min(denrawlo$x),denrawlo$x[denrawlo$y>0],max(denrawlo$x)), y=c(0.0005,denrawlo$y[denrawlo$y>0],0.0005), col="#9999ff", border=NA)
#lines(denrawlo)
lines(denrawhi, lty=1, lwd=2.5, col="black")
lines(dendeblo, lty=1, lwd=2.5, col="green3")
lines(dendebhi, lty=1, lwd=2.5, col="red")

# legend
legend("top", legend=c(
    paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(raw)")
    , paste(formatC(zlo1,format="f",digits=2), "< z ≤", formatC(zlo2,format="f",digits=2), "(debiased)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(raw)")
    , paste(formatC(zhi1,format="f",digits=2), "< z ≤", formatC(zhi2,format="f",digits=2), "(debiased)")
), pch=c(15,NA,NA,NA), lty=c(NA,1,1,1), col=c("#9999ff","green3","black","red"), lwd=c(10,2.5,2.5,2.5), bty="n", pt.cex=2.5, ncol=2)

# axes
aaxis(side=1, tcl=0.3)
aaxis(side=2, tcl=0.3, format="p", las=1)
aaxis(side=3, tcl=0.3, labels=FALSE)
aaxis(side=4, tcl=0.3, unlog=T, labels=FALSE)

# finish up
graphics.off()



