#!/bin/tcsh

# Modify from https://raw.githubusercontent.com/andrewjahn/OpenScience_Scripts/master/doDecon.sh written by andrewjahn
# For the fMRIPrep tutorial, copy and paste this into the "func" directory of ${subj} in the "derivatives/fmriprep" folder
# and type: "tcsh doDecon.sh ${subj}"

set base_path = /Users/TienTong/Desktop/utdallas_demo
set fmriprep_path = $base_path/derivatives/fmriprep/sub-01/func
set input = $fmriprep_path/sub-01_task-em_run-1_space-MNI152NLin6Asym_res-2_desc-preproc_bold.nii.gz
set transx_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-trans_x.txt
set transy_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-trans_y.txt
set transz_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-trans_z.txt
set rotx_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-rot_x.txt
set roty_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-rot_y.txt
set rotz_file = $fmriprep_path/sub-01_task-em_run-1_desc-confounds_timeseries-rot_z.txt

set outpath = /Users/TienTong/Desktop/utdallas_demo/derivatives/betaseries

set sub_raw = $base_path/data/sub-01/func
set face_stim = $sub_raw/sub-01_task-em_run-01_events-face.txt
set scene_stim = $sub_raw/sub-01_task-em_run-01_events-scene.txt
set lexdec_stim = $sub_raw/sub-01_task-em_run-01_events-lexdec.txt

3dDeconvolve -input $input                                                   \
    -automask						                                                     \
    -polort 2                                                                \
    -num_stimts 9                                                            \
    -stim_times_IM 1 $face_stim 'SPMG2'                                      \
    -stim_label 1 face                                                       \
    -stim_times_IM 2 $scene_stim 'SPMG2'                                     \
    -stim_label 2 scene                                                      \
    -stim_times_IM 3 $lexdec_stim 'SPMG2'                                    \
    -stim_label 3 lexdec                                                     \
    -stim_file 4 $transx_file -stim_base 4 -stim_label 4 trans_x             \
    -stim_file 5 $transy_file -stim_base 5 -stim_label 5 trans_y             \
    -stim_file 6 $transz_file -stim_base 6 -stim_label 6 trans_z             \
    -stim_file 7 $rotx_file -stim_base 7 -stim_label 7 rot_x                 \
    -stim_file 8 $roty_file -stim_base 8 -stim_label 8 rot_y                 \
    -stim_file 9 $rotz_file -stim_base 9 -stim_label 9 rot_z                 \
    -jobs 8                                                                  \
    -fout -tout -x1D $outpath/X.xmat.1D -xjpeg $outpath/X.jpg                \
    -x1D_uncensored $outpath/X.nocensor.xmat.1D                              \
    -fitts $outpath/fitts.nii.gz                                             \
    -errts $outpath/errts.nii.gz                                             \
    -bucket $outpath/stats.nii.gz
