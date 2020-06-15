# Sample Definition

## GroupFindingv08

G3CGalv08.fits and G3CF0FGroupv08.fits
Match by GroupID, All matches, All from 1
New catalogue: GroupFindingv08: 184081 rows, 69 columns (duplicate GroupID removed, 2 TOPCAT group columns removed)

## master-full

* TilingCatv46.fits
* DistancesFramesv14.fits
* GroupFindingv08.fits
Triple match by CATAID, all rows from 1
New catalogue: master.fits: 201326 match groups, 221373 rows, 108 columns (10 duplicates removed, z quality flags from TilingCat)

## master-trim

Only the most useful columns selected from above.

## sample-full

Z_TONRY >= 0.002 & (Z_TONRY <= 0.15 | Zfof <= 0.15) & (NQ >= 3 | NQ2_FLAG >= 1) & SURVEY_CLASS >= 1
New catalogue: sample-trim.fits: 49866 rows

## sample-trim

Final sample definition. Only the most useful columns selected from above.
