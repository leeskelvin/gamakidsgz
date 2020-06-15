# manifest

Files in this directory describe the initial sample definition and construct the input file 'gamazoo.csv' which was entered into the Galaxy Zoo database. This manifest marks the beginning of collaborative efforts between GAMA, KiDS and Galaxy Zoo as outlined in our MoU document here: http://www.gama-survey.org/internal/doc/misc/2016-04-20_GAMA_KiDS_GZ_MoU.pdf.

The final sample of ~50000 galaxies was chosen using the following criteria:
Z_TONRY >= 0.002 & (Z_TONRY <= 0.15 | Z_FOF <= 0.15) & (NQ >= 3 | NQ2_FLAG >= 1) & SURVEY_CLASS >= 1
This makes use of data from the TilingCatv46, DistancesFramesv14 and GroupFindingv08 catalogues. Note the fuzzy upper redshift limt, ensuring that grouped galaxies at z>0.15 but with a median group redshift of z<0.15 are also brought into the sample. We hope that this sample is sufficiently large enough to encompass all of our science cases.

Postage stamp imaging has been created for each source. Each postage stamp is 50x50 kpc.

The final decision tree may be seen [here](../gz4_g_tree_crop.pdf).
