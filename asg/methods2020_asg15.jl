################################################################################
#
# Program:      methods2020_asg15.jl
# Purpose:      Use DataFrames to tabulate data
# Description:  Determine frequency of marital status and ICD-9-CM codes
#				in MIMIC-III demo files
# Last modified by:	BCBI (bcbi@brown.edu)
# Last modified on:	2020-05-04
#
################################################################################

using CSV
using DataFrames

# get marital status counts
a_df = CSV.File("/Users/eschen/methods2020/class_files-2020/data/mimic_demo/ADMISSIONS.csv", header=1, footerskip=0) |> DataFrame

ms_count_df = by(a_df, :marital_status, N = :marital_status => length)
sort!(ms_count_df, (:N), rev=(true))
CSV.write("methods2020_asg15_output.txt", ms_count_df)

# get top 5 ICD-9-CM codes
d_df = CSV.File("/Users/eschen/methods2020/class_files-2020/data/mimic_demo/DIAGNOSES_ICD.csv", header=1, footerskip=0) |> DataFrame
icd_count_df = first(sort!(by(d_df, :icd9_code, N = :icd9_code => length), (:N), rev=(true)), 5)
CSV.write("methods2020_asg15_output2.txt", icd_count_df)
