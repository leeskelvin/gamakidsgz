#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)

# definitions
incat = "/gama/lsk/galaxyzoo/rgb/gamakidsgzinput-kronpetro.csv"
indat = read.cat(incat)
filedat = read.cat("input.dat", header=FALSE)
ids = as.numeric(unlist(strsplit(unlist(strsplit(filedat, ".png")), "G"))[seq(2,(length(filedat)*2),by=2)])
dat = match.cat(ids, indat, idname1="CATAID", idname2="CATAID")
pixsize = 0.2

# diameters
diameterminkpc = 10
diametermaxkpc = 100
kronfact = 5
diameterminarcsec = angsize(z=dat[,"Z_TONRY"], r=diameterminkpc, inp="kpc", out="arcsec")
diametermindegree = diameterminarcsec / 3600
diameterminpixel = diameterminarcsec / pixsize
diametermaxarcsec = angsize(z=dat[,"Z_TONRY"], r=diametermaxkpc, inp="kpc", out="arcsec")
diametermaxdegree = diametermaxarcsec / 3600
diametermaxpixel = diametermaxarcsec / pixsize
diameterkronpixel = dat[,"KRON_RADIUS"] * dat[,"A_IMAGE"] * kronfact
toolo = which(diameterkronpixel < diameterminpixel)
toohi = which(diameterkronpixel > diametermaxpixel)
diameterkronpixel[toolo] = diameterminpixel[toolo]
diameterkronpixel[toohi] = diametermaxpixel[toohi]
#diameterkronarcsec = diameterkronpixel * pixsize
#diameterkrondegree = diameterkronarcsec * 3600
#diameterkronkpc = angsize(z=dat[,"Z_TONRY"], r=diameterkronarcsec, inp="arcsec", out="kpc")

# loop over each galaxy
for(j in 1:length(dat[,1])){
    
    # setup
    counter(j, length(dat[,1]), text=dat[j,"CATAID"])
    filename = paste("G", dat[j,"CATAID"], ".jpeg", sep="")
    
    # sdss cutout
    cdim = ceiling(diameterkronpixel[j])
    comm = paste("wget 'http://skyservice.pha.jhu.edu/DR10/ImgCutout/getjpeg.aspx?ra=",dat[j,"RA"],"&dec=",dat[j,"DEC"],"&scale=",pixsize,"&width=",cdim,"&height=",cdim,"'",sep="")
    system(comm)
    outs = grep("getjpeg", system("ls -tr", intern=TRUE), value=TRUE)
    out = outs[length(outs)]
    system(paste("mv '", out, "' ", filename, sep=""))
    
}






