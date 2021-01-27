# SETUP PARAMETERS
#
# parameters used throughout the debiasing notebook.

# data definitions (original output: gz_gama_2018-02-25_debiased.fits)
outdir = os.path.abspath('.')
input_votefrac_cat = f'{outdir}/../gkgz-cleaned.fits.gz'
input_extraval_cat = f'{outdir}/../gkgz-extra.fits.gz'
output_cat = f'{outdir}/../gkgz-debiased.fits.gz'

# column suffix info
input_total_suffix = '_clean_total'
input_frac_suffix = '_clean_frac'
output_frac_suffix = '_deb_frac'
output_priorsample_suffix = '_deb_psamp'

# data column names
R50_column = 'GALRE_r_kpc'
Mr_column = 'absmag_r'
z_column = 'Z_TONRY'
input_votefrac_id = 'subject_id'
input_extraval_id = 'subject_id'

# Half-light radius (R50) and absolute magnitude (Mr) quality cuts
R50lo = 0.4
R50hi = 25
Mrlo = -23
Mrhi = -15

# astrophysical limits
survey_mag_limit = 19.8
volume_redshift_bounds = (0.02, 0.15)

# threshold settings
p_cut = 0.5
p_type = 'multiplicative'  # [additive/multiplicative]
N_cut = 5
null_value = -1

# debiasing sample binning target values
n_voronoi = 30
n_per_z = 50
low_signal_limit = 100
clip_percentile = 5

# debiasing function boundary limits
logistic_bounds = ((0.5, 10), (-10, 10))
exponential_bounds = ((10**(-5), 10), (10**(-5), 10))
log_fv_range = (-1.5, 0.01)

# plotting variables
dpi = 300
cols = plt.rcParams['axes.prop_cycle'].by_key()['color']
cols[0], cols[1] = cols[1], cols[0]

# QUESTION / ANSWER DICTIONARY
#
# From Ross Hart: here, you can adjust what the questions are to be debiased,
# and their order. Note that the order does matter, you need to debias the
# questions further up the tree than the question you are currently debiasing.

# List of questions in order :
q = ['features',        # T00: smooth, features or star/artifact
     'edgeon',          # T01: edge on?
     'bar',             # T02: bar?
     'spiral',          # T03: spiral?
     'bulge',           # T04: face-on bulge prominence
     'spiralwinding',   # T05: arm winding
     'spiralnumber',    # T06: arm number
     'bulgeshape',      # T07: edge-on bulge shape
     'round',           # T08: roundedness
     'mergers',         # T09: merging or tidal debris
     'oddtype',         # T10: ring, lens, irr, other, dust, overlap
     'discuss',         # T11: discuss?
     ]

# Answers for each of the questions in turn:
a = [['smooth', 'features', 'star_or_artifact'],            # T00
     ['yes', 'no'],                                         # T01
     ['bar', 'no_bar'],                                     # T02
     ['spiral', 'no_spiral'],                               # T03
     ['no_bulge', 'obvious', 'dominant'],                   # T04
     ['tight', 'medium', 'loose'],                          # T05
     ['1', '2', '3', '4', 'more_than_4'],                   # T06
     ['rounded', 'boxy', 'no_bulge'],                       # T07
     ['completely_round', 'in_between', 'cigar_shaped'],    # T08
     ['merging', 'tidal_debris', 'both', 'neither'],        # T09
     ['none', 'ring', 'lens_or_arc', 'irregular',
      'other', 'dust_lane', 'overlapping'],                 # T10
     ['yes', 'no'],                                         # T11
     ]

# question labels
lbl_q = ['smooth or featured?',                 # T00
         'edge-on disk?',                       # T01
         'barred?',                             # T02
         'spiral arm pattern?',                 # T03
         'face-on/inclined bulge prominence?',  # T04
         'spiral arm winding?',                 # T05
         'number of spiral arms?',              # T06
         'edge-on bulge shape?',                # T07
         'smooth roundedness?',                 # T08
         'merging or tidal debris?',            # T09
         'odd features?',                       # T10
         'discuss further?',                    # T11
         ]

# answer labels
lbl_a = [['smooth', 'featured', 'star/artifact'],               # T00
         ['edge-on', 'face-on/inclined'],                       # T01
         ['barred', 'unbarred'],                                # T02
         ['spiral arms', 'no spiral arms'],                     # T03
         ['no bulge', 'obvious bulge', 'dominant bulge'],       # T04
         ['tight spiral', 'moderate spiral', 'loose spiral'],   # T05
         ['1 arm', '2 arms', '3 arms', '4 arms', '5+ arms'],    # T06
         ['rounded bulge', 'boxy bulge', 'no bulge'],           # T07
         ['circular', 'in-between', 'cigar shaped'],            # T08
         ['merging', 'tidal debris', 'merging & tidal',
          'no merging/tidal'],                                  # T09
         ['no odd features', 'ring', 'lens/arc',
          'irregularity', 'other', 'dust lane', 'overlap'],     # T10
         ['discuss further', 'no discussion'],                  # T11
         ]

# Required questions for each question in turn:
req_q = [None,          # T00
         [0],           # T01
         [0, 1],        # T02
         [0, 1],        # T03
         [0, 1],        # T04
         [0, 1, 3],     # T05
         [0, 1, 3],     # T06
         [0, 1],        # T07
         [0],           # T08
         [0],           # T09
         [0],           # T10
         None,          # T11
         ]

# Required answers for each previously answered question:
req_a = [None,          # T00
         [1],           # T01
         [1, 1],        # T02
         [1, 1],        # T03
         [1, 1],        # T04
         [1, 1, 0],     # T05
         [1, 1, 0],     # T06
         [1, 0],        # T07
         [0],           # T08
         None,          # T09
         None,          # T10
         None,          # T11
         ]

# Not-req answers: where req_a has multiple (req_q=[] & req_a=None)
not_a = [None,     # T00
         None,     # T01
         None,     # T02
         None,     # T03
         None,     # T04
         None,     # T05
         None,     # T06
         None,     # T07
         None,     # T08
         [2],      # T09
         [2],      # T10
         None,     # T11
         ]
