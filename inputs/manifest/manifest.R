#!/usr/bin/Rscript --no-init-file

# setup
require("astro", quietly=TRUE)
require("astroextras", quietly=TRUE)

# definitions
dat = read.cat("input/gamakidsgzinput-kronpetro.csv")

# required: telescope, survey, RA, Dec, size (petrorad arcsec), m_r, M_r, filename_native, filename_invert
# extra:    spec-z, size (petrorad kpc)

# data
cataid = dat[,"CATAID"]
ext = gama.tiling(tab=cataid)
kmag = read.cat("input/gamakidsgzinput-kronmags.csv")
telescope = "VST 2.6m"
survey = "GAMA-KiDS"
ra = dat[,"RA"]
dec = dat[,"DEC"]
z = as.numeric(dat[,"Z_TONRY"])
petroradpix = as.numeric(dat[,"A_IMAGE"]) * as.numeric(dat[,"PETRO_RADIUS"])
petroradarcsec = petroradpix * 0.339
petroradkpc = angsize(z=z, r=petroradarcsec, inp="arcsec", out="kpc")
#kronradpix = as.numeric(dat[,"A_IMAGE"]) * as.numeric(dat[,"KRON_RADIUS"])
#kronradarcsec = kronradpix * 0.339
#kronradkpc = angsize(z=z, r=kronradarcsec, inp="arcsec", out="kpc")
petroappmag = as.numeric(ext[,"R_PETRO"])
petroabsmag = absmag(m=petroappmag, z=z, H=70, M=0.3)
#kronappmag = as.numeric(kmag[,"MAG_AUTO_r"])
#kronabsmag = absmag(m=kronappmag, z=z, H=70, M=0.3)
region = gama.region(ra)

null = -9999
bad = which(as.numeric(dat[,"A_IMAGE"]) == null)
petroradpix[bad] = null
petroradarcsec[bad] = null
petroradkpc[bad] = null
#kronradpix[bad] = null
#kronradarcsec[bad] = null
#kronradkpc[bad] = null

filenamenative = paste("G", cataid, "-native-424.png", sep="")
filenameinvert = paste("G", cataid, "-invert-424.png", sep="")

cat = cbind(CATAID=cataid, FILENAMENATIVE=filenamenative, FILENAMEINVERT=filenameinvert, TELESCOPE=telescope, SURVEY=survey, RA=ra, DEC=dec, PETRORADARCSEC=petroradarcsec, PETRORADKPC=petroradkpc, PETROAPPMAG=petroappmag, PETROABSMAG=petroabsmag)

cat09 = cat[region=="g09",,drop=FALSE]
cat12 = cat[region=="g12",,drop=FALSE]
cat15 = cat[region=="g15",,drop=FALSE]

# save
write.cat(cat, file="gamazoo.csv")
write.cat(cat09, file="gamazoo09.csv")
write.cat(cat12, file="gamazoo12.csv")
write.cat(cat15, file="gamazoo15.csv")



