# methods2020_program5-df.jl
# DataFrames

# Read and split file with readlines
a_file = "/Users/eschen/methods2020/class_files-2020/data/mimic_demo/ADMISSIONS.csv"
for line in readlines(a_file)
    field_array = split(line, ",")
    println("$(field_array[1]) --- $(field_array[2]) --- $(field_array[10])")
end


# load packages
# CSV.jl: https://juliadata.github.io/CSV.jl/stable/
# DataFrames.jl: https://juliadata.github.io/DataFrames.jl/stable/
println("Loading packages ...")
using DataFrames
using CSV

# load files into DataFrame
println("Loading file ...")
a_df = CSV.File("/Users/eschen/methods2020/class_files-2020/data/mimic_demo/ADMISSIONS.csv", header=1, footerskip=0) |> DataFrame

# print first and last 10 rows
println("\n***FIRST AND LAST 5 ROWS***")
println(first(a_df, 5))
println(last(a_df, 5))

# describe 
println("\n***DESCRIPTION***")
println(describe(a_df))

# get size
#=
nrows, ncols = size(a_df)
for row in 1:nrows
    if a_df[row, :hospital_expire_flag] .== 1
       println("$row -> $(a_df[row, :hospital_expire_flag])")
    end    
end
=#

# created filtered df
# filtered_a_df = a_df[a_df[:hospital_expire_flag] .== 1, [:subject_id, :hadm_id, :insurance]]
filtered_a_df = a_df[a_df.hospital_expire_flag .== 1, [:subject_id, :hadm_id, :insurance]]
println(size(filtered_a_df))
println(describe(filtered_a_df))
println(first(filtered_a_df, 5))

# write to output file
CSV.write("methods2020_program5_output.txt", filtered_a_df)


### ASSIGNMENT 15 ###
# Same as Assignment 3 - question 2 
# 1. Determine frequency of each marital status value as a DataFrame
# 2. Sort results by frequency in descending order
# 3. Write results into a file

# get marital status counts
ms_count_df = by(a_df, :marital_status, N = :marital_status => length)
println(ms_count_df)
sort!(ms_count_df, (:N), rev=(true))
println(ms_count_df)
CSV.write("methods2020_program5_output2.txt", ms_count_df)

# Same as Assignment 3 - question 6
# 1. Determine the top 5 most frequent ICD-9-CM codes (icd9_cm) in DIAGNOSES_ICD.csv.
# Try seeing if you can do it in one line!

d_df = CSV.File("/Users/eschen/methods2020/class_files-2020/data/mimic_demo/DIAGNOSES_ICD.csv", header=1, footerskip=0) |> DataFrame
icd_count_df = first(sort!(by(d_df, :icd9_code, N = :icd9_code => length), (:N), rev=(true)), 5)
println(icd_count_df)