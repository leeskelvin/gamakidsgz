# SETUP PARAMETERS
#
# parameters used throughout the debiasing notebook.

# data definitions
outdir = os.path.abspath('/project/lskelvin/decals')
input_votefrac_cat = f'{outdir}/current_final_dr5_result_n30.fits.gz'
input_extraval_cat = f'{outdir}/current_final_dr5_result_extra_n30.fits.gz'
output_cat = f'{outdir}/current_final_dr5_result_debiased_n30.fits.gz'

# column suffix info
input_total_suffix = '_total-votes'
input_frac_suffix = '_fraction'
output_frac_suffix = '_deb_frac'
output_priorsample_suffix = '_deb_psamp'

# data column names
R50_column = 'R50_kpc'
Mr_column = 'absmag_r_correct'
z_column = 'redshift'
input_votefrac_id = 'iauname'
input_extraval_id = 'iauname'

# Half-light radius (R50) and absolute magnitude (Mr) quality cuts
R50lo = 0.4
R50hi = 35
Mrlo = -24
Mrhi = -15

# astrophysical limits
survey_mag_limit = 17.77
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
q = ['smooth-or-featured',  # T00: smooth, features or star/artefact
     'disk-edge-on',        # T01: edge on?
     'bar',                 # T02: bar?
     'has-spiral-arms',     # T03: spiral?
     'bulge-size',          # T04: face-on bulge prominence
     'spiral-winding',      # T05: arm winding
     'spiral-arm-count',    # T06: arm number
     'edge-on-bulge',       # T07: edge-on bulge shape
     'how-rounded',         # T08: roundedness
     'merging',             # T09: merging or tidal debris
     ]

# Answers for each of the questions in turn:
a = [['smooth', 'featured-or-disk', 'artifact'],                    # T00
     ['yes', 'no'],                                                 # T01
     ['no', 'weak', 'strong'],                                      # T02
     ['no', 'yes'],                                                 # T03
     ['none', 'small', 'moderate', 'large', 'dominant'],            # T04
     ['tight', 'medium', 'loose'],                                  # T05
     ['1', '2', '3', '4', 'more-than-4', 'cant-tell'],              # T06
     ['rounded', 'boxy', 'none'],                                   # T07
     ['round', 'in-between', 'cigar-shaped'],                       # T08
     ['none', 'minor-disturbance', 'major-disturbance', 'merger'],  # T09
     ]

# question labels
lbl_q = ['features',            # T00
         'edge-on',             # T01
         'bar',                 # T02
         'spiral arm',          # T03
         'bulge prominence',    # T04
         'spiral winding',      # T05
         'spiral arms',         # T06
         'bulge shape',         # T07
         'roundedness',         # T08
         'mergers',             # T09
         ]

# answer labels
lbl_a = [['smooth', 'featured', 'star/artefact'],       # T00
         ['edge-on', 'face-on/inclined'],               # T01
         ['unbarred', 'weak bar', 'strong_bar'],        # T02
         ['no spiral arms', 'spiral arms'],             # T03
         ['no bulge', 'small bulge', 'moderate bulge',
          'obvious bulge', 'dominant bulge'],           # T04
         ['tight spiral', 'moderate spiral',
          'loose spiral'],                              # T05
         ['1 arm', '2 arms', '3 arms', '4 arms',
          '5+ arms', 'cant tell'],                      # T06
         ['rounded bulge', 'boxy bulge', 'no bulge'],   # T07
         ['circular', 'in-between', 'cigar shaped'],    # T08
         ['no merger', 'minor disturbance',
          'major disturbance', 'merger'],               # T09
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
         ]

# Not-req answers: where req_a has multiple (req_q=[] & req_a=None)
not_a = [None,  # T00
         None,  # T01
         None,  # T02
         None,  # T03
         None,  # T04
         None,  # T05
         None,  # T06
         None,  # T07
         None,  # T08
         [2],   # T09
         ]
