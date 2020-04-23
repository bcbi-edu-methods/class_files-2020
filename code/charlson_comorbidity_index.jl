###############################
# Raj Anand
# Charlson Comorbidity Index
# This program will calculate the max CCI score for diabetic patients over the course of their hospitalization
# Update for Julia 1.2 on 4/21/20
######################################################################

using DataFrames
using CSV

# load  ICD9 diagnosis code data
# load in admission data
# load in age data
cci_dx = CSV.read("diagnoses.csv", missingstring = "NA") |> DataFrame!
cci_admissions = CSV.read("diabetic_admissions_data.csv", missingstring = "NA") |> DataFrame!
cci_age = CSV.read("demographics.csv", missingstring = "NA") |> DataFrame!


#insert a column into cci_age for age age_bracket and calculate age score
cci_age = cci_age[:, [:HADM_ID, :AGE]]

insert!(cci_age, 3, 0, :age_bracket)
for i in 1:nrow(cci_age)
	if cci_age[i, :AGE] < 50
		cci_age[i, :age_bracket] = 0
	elseif 50 <= cci_age[i, :AGE] <= 59
		cci_age[i, :age_bracket] = 1
	elseif 60 <= cci_age[i, :AGE] <= 69
                cci_age[i, :age_bracket] = 2
	elseif 70 <= cci_age[i, :AGE] <= 79
                cci_age[i, :age_bracket] = 3
	else
                cci_age[i, :age_bracket] = 4
	end
end

display(describe(cci_age))

#insert a column for ICD9 category
cci_dx.cci_category = "Other"
cci_dx.cci_score = "0"
display(describe(cci_dx))

# Define sets for ICD_9 values so that they can be used to replace IC9_codes in the original data set
congest_heart_failure = Set(["39891","40201","40211","40291","40401","40403","40411","40413","40491","40493","4524","4255","4256","4257","4258","4259"])
periph_vasc_disease = Set(["0930","4373","4431","4432","4433","4434","4435","4436","4437","4438","4439","471","5571","5579","V434"])
cereberovascular_disease = Set(["36234"])
dementia = Set(["2941","3312"])
chronic_pulmonary_disease = Set(["4168","4169","5064","5081","5088"])
rheumatic_disease = Set(["4465","7100","7101","7102","7103","7104","7140","7141","7142","7148"])
mild_liver_disease = Set(["07022","07023","07032","07033","07044","07054","0706","0709","5733","5734","5738","5739","V427"])
diabetes = Set(["25000","25001","25002","25003","25010","25011","25012","25013","25020","25021","25022","25023","25030","25031","25032","25033"])
diabetes_complication = Set(["2504","2505","2506","2507"])
hemiplegia = Set(["3341","3440","3441","3442","3443","3444","3445","3446","3449"])
renal_disease = Set(["40301","40311","40391","40402","40403","40412","40413","40492","40493","5830","5831","5832","5833","5834","5835","5836","5837","5880","V420","V451"])
malignancy = Set(["2386"])
severe_liver_disease = Set(["4560","4561","4562","5722","5723","5724","5725","5726","5727","5728"])

# Assign Value from CCI score to each ICD9_Code using regular expressions and the sets above
for i in 1:nrow(cci_dx)
        if (occursin(r"^410|^412", cci_dx[i, :ICD9_CODE]))
            cci_dx[i, :cci_score] = 1
            cci_dx[i, :cci_category] = "Myocardial Infarction"
        elseif (occursin(r"^428", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in congest_heart_failure)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Congestive Heart Failure"
        elseif (occursin(r"^440|^441", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in periph_vasc_disease)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Peripheral Vacular Disease"
        elseif (occursin(r"^430|^431|^432|^433|^434|^435|^436|^437|^438", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in cereberovascular_disease)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Cereberovascular Disease"
        elseif (occursin(r"^290", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in dementia)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Dementia"
        elseif (occursin(r"^490|^491|^492|^493|^494|^495|^496|^497|^498|^499|^500|^501|^502|^502|^503|^504|^505", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in chronic_pulmonary_disease)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Chronic Pulmonary Disease"
        elseif (occursin(r"^725", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in rheumatic_disease)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Rheumatic Disease"
        elseif (occursin(r"^531|^532|^533|^534", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Peptic Ulcer Disease"
        elseif (occursin(r"^411|^413|^414|^440", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in mild_liver_disease)
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Mild Liver Disease"
        elseif (occursin(r"^2500|^2501|^2502|^2503|^2508|^2509", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 1
                cci_dx[i, :cci_category] = "Diabetes"
        elseif (occursin(r"^2504|^2505|^2506|^2507", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 2
                cci_dx[i, :cci_category] = "Diabetes with Complications"
        elseif (occursin(r"^342|^343", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in hemiplegia)
                cci_dx[i, :cci_score] = 2
                cci_dx[i, :cci_category] = "Hemiplegia"
        elseif (occursin(r"^582|^586|^V56", cci_dx[i, :ICD9_CODE])) || (cci_dx[i, :ICD9_CODE] in renal_disease)
                cci_dx[i, :cci_score] = 2
                cci_dx[i, :cci_category] = "Renal Disease"
        elseif (occursin(r"^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^161|^162|^163|^164|^165|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 2
                cci_dx[i, :cci_category] = "Malignancy"
        elseif (cci_dx[i, :ICD9_CODE] in severe_liver_disease)
                cci_dx[i, :cci_score] = 3
                cci_dx[i, :cci_category] = "Severe Liver Disease"
        elseif (occursin(r"^196|^197|^198|^199", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 6
                cci_dx[i, :cci_category] = "Metastatic Solid Tumor"
        elseif (occursin(r"^042|^043|^044", cci_dx[i, :ICD9_CODE]))
                cci_dx[i, :cci_score] = 6
                cci_dx[i, :cci_category] = "AIDS/HIV"
        else
                cci_dx[i, :cci_score] = 0
                cci_dx[i, :cci_category] = "N/A"
        end
end

MYOCARD = by(cci_dx[cci_dx[:cci_category] .== "Myocardial Infarction", :], :HADM_ID, df -> maximum(df[:cci_score]))
CHF = by(cci_dx[cci_dx[:cci_category] .== "Congestive Heart Failure", :], :HADM_ID, df -> maximum(df[:cci_score]))
PVD = by(cci_dx[cci_dx[:cci_category] .== "Peripheral Vacular Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
CBV = by(cci_dx[cci_dx[:cci_category] .== "Cereberovascular Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
DEM = by(cci_dx[cci_dx[:cci_category] .== "Dementia", :], :HADM_ID, df -> maximum(df[:cci_score]))
PULM = by(cci_dx[cci_dx[:cci_category] .== "Chronic Pulmonary Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
RHEUM = by(cci_dx[cci_dx[:cci_category] .== "Rheumatic Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
ULCER = by(cci_dx[cci_dx[:cci_category] .== "Peptic Ulcer Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
MLIVER = by(cci_dx[cci_dx[:cci_category] .== "Mild Liver Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
DM = by(cci_dx[cci_dx[:cci_category] .== "Diabetes", :], :HADM_ID, df -> maximum(df[:cci_score]))
DMCX = by(cci_dx[cci_dx[:cci_category] .== "Diabetes with Complications", :], :HADM_ID, df -> maximum(df[:cci_score]))
HEMI = by(cci_dx[cci_dx[:cci_category] .== "Hemiplegia", :], :HADM_ID, df -> maximum(df[:cci_score]))
RENLFAIL = by(cci_dx[cci_dx[:cci_category] .== "Renal Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
MALIG = by(cci_dx[cci_dx[:cci_category] .== "Malignancy", :], :HADM_ID, df -> maximum(df[:cci_score]))
SLIVER = by(cci_dx[cci_dx[:cci_category] .== "Severe Liver Disease", :], :HADM_ID, df -> maximum(df[:cci_score]))
TUMOR = by(cci_dx[cci_dx[:cci_category] .== "Metastatic Solid Tumor", :], :HADM_ID, df -> maximum(df[:cci_score]))
AIDS = by(cci_dx[cci_dx[:cci_category] .== "AIDS/HIV", :], :HADM_ID, df -> maximum(df[:cci_score]))

# relabel each category from by function output
rename!(MYOCARD, :x1, :MYOCARD)
rename!(CHF, :x1, :CHF)
rename!(PVD, :x1, :PVD)
rename!(CBV, :x1, :CBV)
rename!(DEM, :x1, :DEM)
rename!(PULM, :x1, :PULM)
rename!(RHEUM, :x1, :RHEUM)
rename!(ULCER, :x1, :ULCER)
rename!(MLIVER, :x1, :MLIVER)
rename!(DM, :x1, :DM)
rename!(DMCX, :x1, :DMCX)
rename!(HEMI, :x1, :HEMI)
rename!(RENLFAIL, :x1, :RENLFAIL)
rename!(MALIG, :x1, :MALIG)
rename!(SLIVER, :x1, :SLIVER)
rename!(TUMOR, :x1, :TUMOR)
rename!(AIDS, :x1, :AIDS)


# create a master table with all of the values in a row for a single hospitalization using joins
cci_master_table = join(MYOCARD, CHF, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, PVD, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, CBV, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, DEM, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, PULM, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, RHEUM, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, ULCER, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, MLIVER, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, DM, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, DMCX, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, HEMI, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, RENLFAIL, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, MALIG, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, SLIVER, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, TUMOR, on = :HADM_ID, kind = :outer)
cci_master_table = join(cci_master_table, AIDS, on = :HADM_ID, kind = :outer)

# add in the admissions data (ethnicity, demographics, etc)
cci_master_table = join(cci_admissions, cci_master_table, on = :HADM_ID, kind = :left)
cci_master_table = join(cci_master_table, cci_age, on = :HADM_ID, kind = :outer)
display(cci_master_table)


# create a function to recode
function recode!(dat::DataFrame, col::Symbol, recode_lookup::Dict, typ::DataType)
    tmp = dat[col]
    n = size(dat, 1)
    if typ <: Number
        dat[col] = zeros(typ, n)
    else
        dat[col] = DataArray(repeat([""], inner = n))
    end
    for i = 1:n
        dat[i, col] = recode_lookup[tmp[i]]
    end
end

# Use our function to re-code columns, set NA as 0, 1 as 1
recode!(cci_master_table, :MYOCARD, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :CHF, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :PVD, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :CBV, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :DEM, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :PULM, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :RHEUM, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :ULCER, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :MLIVER, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :DM, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :DMCX, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :HEMI, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :RENLFAIL, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :MALIG, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :SLIVER, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :TUMOR, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)
recode!(cci_master_table, :AIDS, Dict(NA => 0, 1 => 1, 2 => 2, 3 => 3, 6 => 6), Int)

#calculate score for Diabetes, Liver, Neuro, Malignancy
insert!(cci_master_table, 20, 0, :DM_score)
insert!(cci_master_table, 20, 0, :LIVER_score)
insert!(cci_master_table, 20, 0, :NEURO_score)
insert!(cci_master_table, 20, 0, :MALIG_score)

for i in 1:nrow(cci_master_table)
        if cci_master_table[i, :DM] >= cci_master_table[i, :DMCX]
                cci_master_table[i, :DM_score] = cci_master_table[i, :DM]
        elseif cci_master_table[i, :DM] < cci_master_table[i, :DMCX]
                cci_master_table[i, :DM_score] = cci_master_table[i, :DMCX]
        else
                cci_master_table[i, :DM_score] = 0
        end
end

for i in 1:nrow(cci_master_table)
        if cci_master_table[i, :MLIVER] >= cci_master_table[i, :SLIVER]
                cci_master_table[i, :LIVER_score] = cci_master_table[i, :MLIVER]
        elseif cci_master_table[i, :MLIVER] < cci_master_table[i, :SLIVER]
                cci_master_table[i, :LIVER_score] = cci_master_table[i, :SLIVER]
        else
                cci_master_table[i, :LIVER_score] = 0
        end
end

for i in 1:nrow(cci_master_table)
        if cci_master_table[i, :CBV] >= cci_master_table[i, :HEMI]
                cci_master_table[i, :NEURO_score] = cci_master_table[i, :CBV]
        elseif cci_master_table[i, :CBV] < cci_master_table[i, :HEMI]
                cci_master_table[i, :NEURO_score] = cci_master_table[i, :HEMI]
        else
                cci_master_table[i, :NEURO_score] = 0
        end
end

for i in 1:nrow(cci_master_table)
        if cci_master_table[i, :MALIG] >= cci_master_table[i, :TUMOR]
                cci_master_table[i, :MALIG_score] = cci_master_table[i, :TUMOR]
        elseif cci_master_table[i, :MALIG] < cci_master_table[i, :TUMOR]
                cci_master_table[i, :MALIG_score] = cci_master_table[i, :TUMOR]
        else
                cci_master_table[i, :MALIG_score] = 0
        end
end


# sum the various cci categories to get one composite score
cci_master_table[:cci_sum] = cci_master_table[:MYOCARD] + cci_master_table[:CHF] + cci_master_table[:PVD] + cci_master_table[:NEURO_score] + cci_master_table[:DEM] + cci_master_table[:PULM] + cci_master_table[:RHEUM] + cci_master_table[:ULCER] + cci_master_table[:LIVER_score] + cci_master_table[:DM_score] + cci_master_table[:RENLFAIL] + cci_master_table[:MALIG_score] + cci_master_table[:AIDS] + cci_master_table[:age_bracket]

display(cci_master_table)
describe(cci_master_table)

#create a table with columns of interest
cci_master_table = cci_master_table[:, [:HADM_ID, :SUBJECT_ID, :MYOCARD, :CHF, :PVD, :CBV, :DEM, :PULM, :RHEUM, :ULCER, :MLIVER, :DM, :DMCX, :HEMI, :RENLFAIL, :MALIG, :SLIVER, :TUMOR, :AIDS, :MALIG_score, :NEURO_score, :LIVER_score, :DM_score, :age_bracket, :cci_sum, :HOSPITAL_EXPIRE_FLAG]]


# writeout of table
CSV.write("cci_score.csv", cci_master_table)
