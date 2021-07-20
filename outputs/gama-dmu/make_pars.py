#!/usr/bin/env python3

import os
from astropy.table import Table

indir = '.'
cats = sorted([x for x in os.listdir(indir) if '.fits.gz' in x])
print('Generating .par files for:')
_ = [print('* ' + x) for x in cats]

parDMU = 'GKGZMorphology'
parDATE = '2021-05-25'
parAUTHOR = 'Lee Kelvin <lkelvin@astro.princeton.edu>'

for cat in cats:
    parNAME, parVERSION = cat.split('.fits.gz')[0].split('v0')
    parVERSION = 'v0' + parVERSION
    parfile = parNAME + parVERSION + '.par'
    dat = Table.read(cat)

    # opening blurb
    parblurb = [parDMU, parNAME, parVERSION, parDATE, parAUTHOR]
    with open(parfile, 'w') as par:
        for blurb in parblurb:
            par.write('# ' + blurb + '\n')
        par.write('#\n')

    # catalogue description
    notes = ''
    if 'Alpha' in cat:
        notes = ['# This table provides alpha (raw) GAMA-KiDS Galaxy Zoo classification results.',
                 '# Each row in this catalogue corresponds to an individual galaxy classified by',
                 '# a singular user. Basic information about the classifier (user) are provided,',
                 '# followed by the chosen answer for each question (gama-N columns). For a full',
                 '# description of all decision tree question-answer pairs, see the notes file.']
    if 'Binned' in cat:
        notes = ['# This table provides binned GAMA-KiDS Galaxy Zoo classification results. To',
                 '# construct this table, alpha (raw) level results are concatenated per-galaxy.',
                 '# The retirement number for each galaxy was set at 40, i.e., each galaxy aims',
                 '# for at least 40 distinct classifiers. The _total columns show the total',
                 '# number of classifiers answering a question; _frac shows the answer fraction.']
    if 'Cleaned' in cat:
        notes = ['# This table provides cleaned (user-weighted) GAMA-KiDS Galaxy Zoo',
                 '# classification results. Following Willett et al. (2013), each user is',
                 '# assigned a weight according to their consistency with other classifiers.',
                 '# Accordingly, their classification results are weighted here in order to',
                 '# reduce the influence of potentially unreliable classifiers.']
    if 'Debiased' in cat:
        notes = ['# This table provides debiased GAMA-KiDS Galaxy Zoo classification results.',
                 '# Following Hart et al. (2016), cleaned (user-weighted) vote fractions are',
                 '# corrected for the effect of redshift bias (*_deb_* columns). Additionally,',
                 '# the "prior sample" psamp flag shows the galaxies for which it makes sense to',
                 '# ask a given question (p_prior >= 0.5 AND N >= 5).']
    if 'Extra' in cat:
        notes = ['# This table lists additional ancillary data taken from existing GAMA',
                 '# catalogues which have been used during data reduction of the GAMA-KiDS',
                 '# Galaxy Zoo dataset. GAMA data in this table are derived from TilingCatv46,',
                 '# DistancesFramesv14 and GroupFindingv08. GAMA CATAIDs have been matched to',
                 '# Zooniverse IDs and galaxy zoo classification IDs, for reference.']
    if 'Final' in cat:
        notes = ['# This table provides final GAMA-KiDS Galaxy Zoo classification results, and',
                 '# should be considered the primary scientific output. Total vote counts are',
                 '# identical to those in the cleaned catalogue, whereas vote fractions and',
                 '# prior probability flags are identical to those in the debiased catalogue.',
                 '# Additional information on postage stamp filenames and URLs are also provided.']
    if 'UserWeights' in cat:
        notes = ['# This table provides user-weighting for each unique classifier contributing',
                 '# to the GAMA-KiDS Galaxy Zoo project. Following Willett et al. (2013), each',
                 '# user is assigned a weight according to their consistency with other',
                 '# classifiers. Usernames have been anonymised, here replaced with the user_id',
                 '# column. Negative user IDs correspond to users who were not logged in.']
    with open(parfile, 'a') as par:
        for note in notes:
            par.write(note + '\n')
        par.write('#\n')

    # column descriptors
    with open(parfile, 'a') as par:
        par.write(f'{"# parameter":35s} '
                  f'{"column":6s} '
                  f'{"unit":10s} '
                  f'{"UCD":16s} '
                  f'{"description"}\n')
    counter = 0
    for col in dat.columns:
        counter += 1
        units = '-'
        ucd = '-'
        desc = '-'
        # unique columns
        if col == 'id':
            ucd = 'meta.id'
            desc = 'classification ID'
        if col == 'subject_id':
            ucd = 'meta.id'
            desc = 'galaxy zoo ID'
        if col == 'user_id':
            ucd = 'meta.id'
            desc = 'user ID'
        if col == 'created_at':
            ucd = 'time.processing'
            desc = 'classification date/time'
        if col == 'lang':
            desc = 'user client language'
        if col == 'user_agent':
            desc = 'user client software'
        if col == 'gama-0':
            desc = 'smooth, featured or star/artifact?'
        if col == 'gama-1':
            desc = 'edge-on disk?'
        if col == 'gama-2':
            desc = 'barred?'
        if col == 'gama-3':
            desc = 'spiral arm pattern?'
        if col == 'gama-4':
            desc = 'bulge prominence?'
        if col == 'gama-5':
            desc = 'spiral arm winding?'
        if col == 'gama-6':
            desc = 'spiral arm number?'
        if col == 'gama-7':
            desc = 'central bulge?'
        if col == 'gama-8':
            desc = 'roundedness?'
        if col == 'gama-9':
            desc = 'merging/tidal debris?'
        if col == 'gama-10':
            desc = 'odd features?'
        if col == 'gama-11':
            desc = 'further discussion?'
        if col == 'CATAID':
            ucd = 'meta.id'
            desc = 'GAMA CATAID'
        if col == 'zooniverse_id':
            ucd = 'meta.id'
            desc = 'Zooniverse ID'
        if col == 'RA':
            units = 'deg'
            ucd = 'pos.eq.ra'
            desc = 'right ascension'
        if col == 'DEC':
            units = 'deg'
            ucd = 'pos.eq.dec'
            desc = 'declination'
        if col == 'absmag_r':
            units = 'mag'
            ucd = 'phys.magAbs'
            desc = 'absolute r-band magnitude'
        if col == 'GALRE_r_kpc':
            units = 'kpc'
            ucd = 'phys.size.radius'
            desc = 'absolute half-light radius'
        if col == 'Z_TONRY':
            ucd = 'src.redshift'
            desc = 'spectroscopic redshift'
        if col == 'Zfof':
            ucd = 'src.redshift'
            desc = 'group friends-of-friends redshift'
        # filenames / URLs
        if 'FILENAME_' in col:
            ucd = 'meta.file'
        if 'URL_' in col:
            ucd = 'meta.ref.url'
        if col == 'FILENAME_NATIVE':
            desc = 'PNG file path on the server, native colour map'
        if col == 'FILENAME_INVERT':
            desc = 'PNG file path on the server, inverted colour map'
        if col == 'URL_NATIVE':
            desc = 'link to PNG, native colour map'
        if col == 'URL_INVERT':
            desc = 'link to PNG, inverted colour map'
        if col == 'URL_NATIVE_424':
            desc = 'link to PNG, native colour map (424x424 pixel scaled)'
        if col == 'URL_INVERT_424':
            desc = 'link to PNG, inverted colour map (424x424 pixel scaled)'
        if col == 'URL_THUMB':
            desc = 'link to PNG, native colour map (thumbnail)'
        # questions
        if 'features_' in col:
            desc = 'smooth, featured or star/artifact'
        if 'edgeon_' in col:
            desc = 'edge-on disk'
        if 'bar_' in col:
            desc = 'barred'
        if 'spiral_' in col:
            desc = 'spiral arm pattern'
        if 'bulge_' in col:
            desc = 'bulge prominence'
        if 'spiralwinding_' in col:
            desc = 'spiral arm winding'
        if 'spiralnumber_' in col:
            desc = 'spiral arm number'
        if 'bulgeshape_' in col:
            desc = 'central bulge'
        if 'round_' in col:
            desc = 'roundedness'
        if 'mergers_' in col:
            desc = 'merging/tidal debris'
        if 'oddtype_' in col:
            desc = 'odd features'
        if 'discuss_' in col:
            desc = 'further discussion'
        # binned / cleaned / debiased
        if '_bin_' in col:
            desc += ': binned (raw)'
        if '_clean_' in col:
            desc += ': cleaned (user-weighted)'
        if '_deb_' in col:
            desc += ': debiased'
        # answers: features
        if 'features_smooth' in col:
            desc += ' smooth'
        if 'features_features' in col:
            desc += ' featured'
        if 'features_star' in col:
            desc += ' star/artifact'
        # answers: edgeon
        if 'edgeon_yes' in col:
            desc += ' yes'
        if 'edgeon_no' in col:
            desc += ' no'
        # answers: bar
        if 'bar_bar' in col:
            desc += ' barred'
        if 'bar_no_bar' in col:
            desc += ' unbarred'
        # answers: spiral
        if 'spiral_spiral' in col:
            desc += ' yes'
        if 'spiral_no_spiral' in col:
            desc += ' no'
        # answers: bulge
        if 'bulge_no_bulge' in col:
            desc += ' no bulge'
        if 'bulge_obvious' in col:
            desc += ' obvious'
        if 'bulge_dominant' in col:
            desc += ' dominant'
        # answers: spiralwinding
        if 'spiralwinding_tight' in col:
            desc += ' tight'
        if 'spiralwinding_medium' in col:
            desc += ' medium'
        if 'spiralwinding_loose' in col:
            desc += ' loose'
        # answers: spiralnumber
        if 'spiralnumber_1' in col:
            desc += ' 1'
        if 'spiralnumber_2' in col:
            desc += ' 2'
        if 'spiralnumber_3' in col:
            desc += ' 3'
        if 'spiralnumber_4' in col:
            desc += ' 4'
        if 'spiralnumber_more' in col:
            desc += ' more than 4'
        # answers: bulgeshape
        if 'bulgeshape_rounded' in col:
            desc += ' rounded'
        if 'bulgeshape_boxy' in col:
            desc += ' boxy'
        if 'bulgeshape_no_bulge' in col:
            desc += ' no bulge'
        # answers: round
        if 'round_completely_round' in col:
            desc += ' completely round'
        if 'round_in_between' in col:
            desc += ' in-between'
        if 'round_cigar_shaped' in col:
            desc += ' cigar shaped'
        # answers: merging
        if 'mergers_merging' in col:
            desc += ' merging'
        if 'mergers_tidal' in col:
            desc += ' tidal debris'
        if 'mergers_both' in col:
            desc += ' merging and tidal debris'
        if 'mergers_neither' in col:
            desc += ' neither merging nor tidal debris'
        # answers: oddtype
        if 'oddtype_none' in col:
            desc += ' none'
        if 'oddtype_ring' in col:
            desc += ' ring'
        if 'oddtype_lens_or_arc' in col:
            desc += ' lens or arc'
        if 'oddtype_irregular' in col:
            desc += ' irregular'
        if 'oddtype_other' in col:
            desc += ' other'
        if 'oddtype_dust_lane' in col:
            desc += ' dust lane'
        if 'oddtype_overlapping' in col:
            desc += ' overlapping'
        # answers: discuss
        if 'discuss_yes' in col:
            desc += ' yes'
        if 'discuss_no' in col:
            desc += ' no'
        # total / fraction / psamp
        if '_total' in col:
            desc += ' vote total'
        if '_frac' in col:
            ucd = 'arith.ratio'
            desc += ' vote fraction'
        if '_psamp' in col:
            ucd = 'meta.code'
            desc += ' prior sample flag'
        with open(parfile, 'a') as par:
            par.write(f'{col:35s} '
                      f'{str(counter):6s} '
                      f'{units:10s} '
                      f'{ucd:16s} '
                      f'{desc}\n')

    # # finish up
    # with open(parfile, 'a') as par:
    #     par.write('\n')
