######################################################################
#Raj Anand
# Elixhauser Indexing
# This program will calculate the max Elixhauser score for patients in MIMIC over their hospitalization using ICD9 codes
# Update for Julia 1.2 on 4/21/20
######################################################################

using DataFrames
using CSV

# load  ICD9 diagnosis code data
# load in admission data
# load in age data
elix_dx = CSV.read("diagnoses.csv", missingstring = "NA") |> DataFrame!
elix_admissions = CSV.read("diabetic_admissions_data.csv", missingstring = "NA") |> DataFrame!


#insert a column for ICD9 category
elix_dx.elix_category = "Other"
elix_dx.elix_score = "0"
display(describe(cci_dx))

# Define sets for ICD_9 values so that they can be used to replace IC9_codes in the original data set
congest_heart_failure = Set(["39891","40201","40211","40291","40401","40403","40411","40413","40491","40493","4524","4255","4257","4258","4259"])
cardiac_arrhythmia = Set(["4260","42613","4267","4269","42610","42612","4270","4271","4272","42731","42732","42741""42742","42760","42761","42769","42781","42789","4279","7850","99601","99604","V450","V533"])
valvular_disease = Set(["0932","7463","7464","7465","7466","V422","V433"])
pulm_circ_disorder = Set(["4150","4151","4170","4178","4179"])
periph_vasc_disease = Set(["0930","4373","4431","4432","4433","4434","4435","4436","4437","4438","4439","4471","5571","5579","V434"])
paralysis = Set(["3341","3440","3441","3442","3443","3444","3445","3446","3449"])
neuro_disorder = Set(["3319","3320","3321","3334","3335","33392","3362","3481","3483","7803","7843"])
chronic_pulmonary_disease = Set(["4168","4169","5064","5081","5088"])
diabetes_no_complication = Set(["2500","2501","2502","2503"])
diabetes_complication = Set(["2504","2505","2506","2507","2508","2509"])
hypothyroidism = Set(["2409","2461","2468"])
renal_disease = Set(["40301","40311","40391","40402","40403","40412","40413","40492","40493","5880","V420","V451"])
liver_disease = Set(["07022","07023","07032","07033","07044","07054","0706","0709","4560","4561","4562","5722","5723","5724","5725","5726","5727","5728","5733","5734","5738","5739","V427"])
peptic_ulcer = Set(["5317","5319","5327","5329","5337","5339","5347","5349"])
lymphoma = Set(["2030","2386"])
rheumatic_disease = Set(["7100","7101","7102","7103","7104","7108","7109","7112","7193","7285","72889","72930"])
coagulopathy = Set(["2871","2873","2874","2875"])
wt = Set(["7832","7994"])
anemia = Set(["2801","2808","2809"])
alcohol_abuse = Set(["2652","2911","2912","2913","2915","2916","2917","2918","2919","3030","3039","3050","3575","4255","5353","5710","5711","5712","5713","V113"])
drug_abuse = Set(["3052","3053","3054","3055","3056","3057","3058","3059","V6542"])
psychosis = Set(["2938","29604","29614","29644","29654"])
depression = Set(["2962","2963","2965","3004","311"])

# Assign Value from elix score to each ICD9_Code using regular expressions and the sets above
for i in 1:nrow(elix_dx)
        if (occursin(r"^428", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in congest_heart_failure)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Congestive Heart Failure"
        elseif (elix_dx[i, :ICD9_CODE] in cardiac_arrhythmia)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Cardiac Arrhythmias"
        elseif (occursin(r"^394|^395|^396|^397|^424", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in valvular_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Valvular Disease"
        elseif (occursin(r"^416", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in pulm_circ_disorder)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Pulmonary Circulation Disorders"
        elseif (occursin(r"^440|^441", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in periph_vasc_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Peripheral Vascular Disorders"
        elseif (occursin(r"^401", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Hypertension, Uncomplicated"
        elseif (occursin(r"^402|^403|^404|^405", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Hypertension, Complicated"
        elseif (occursin(r"^342|^343", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in paralysis)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Paralysis"
        elseif (occursin(r"^334|^335|^340|^341|^345", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in neuro_disorder)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Other Neurologic Disorders"
        elseif (occursin(r"^490|^491|^492|^493|^494|^495|^496|^497|^498|^499|^500|^501|^502|^502|^503|^504|^505", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in chronic_pulmonary_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Chronic Pulmonary Disease"
        elseif (occursin(r"^2500|^2501|^2502|^2503", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Diabetes"
        elseif (occursin(r"^2504|^2505|^2506|^2507|^2508|^2509", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Diabetes with Complications"
        elseif (occursin(r"^243|^244", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in hypothyroidism)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Hypothyroidism"
        elseif (occursin(r"^585|^586|^V56", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in renal_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Renal Disease"
        elseif (occursin(r"^570|^571", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in liver_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Liver Disease"
        elseif (occursin(r"^5317|^5319|^5327|^5329|^5337|^5339|^5347|^5349", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Peptic Ulcer Disease"
        elseif (occursin(r"^042|^043|^044", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "AIDS/HIV"
        elseif (occursin(r"^200|^201|^202", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in lymphoma)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Lymphoma"
        elseif (occursin(r"^196|^197|^198|^199", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Metastatic Tumor"
        elseif (occursin(r"^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^161|^162|^163|^164|^165|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Malignancy"
        elseif (occursin(r"^446|^714|^720|^725", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in rheumatic_disease)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Rheumatic Disease"
        elseif (occursin(r"^286", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in coagulopathy)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Coagulopathy"
        elseif (occursin(r"^2780", elix_dx[i, :ICD9_CODE]))
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Obesity"
        elseif (occursin(r"^260|^261|^262|^263", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in wt)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Weight Loss"
        elseif (occursin(r"^276", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] == "2536")
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Fluid and Electrolye Disorders"
        elseif (elix_dx[i, :ICD9_CODE] == "2800")
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Blood Loss Anemia"
        elseif (occursin(r"^281", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in anemia)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Defiency Anemia"
        elseif (occursin(r"^980", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in alcohol_abuse)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Alcohol Abuse"
        elseif (occursin(r"^292|^304", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in drug_abuse)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Drug Abuse"
        elseif (occursin(r"^295|^298", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in psychosis)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Psychoses"
        elseif (occursin(r"^309", elix_dx[i, :ICD9_CODE])) || (elix_dx[i, :ICD9_CODE] in depression)
                elix_dx[i, :elix_score] = 1
                elix_dx[i, :elix_category] = "Depression"
        else
                elix_dx[i, :elix_score] = 0
                elix_dx[i, :elix_category] = "N/A"
        end
end

# find the max for each category by hospitalization
CHF = by(elix_dx[elix_dx[:elix_category] .== "Congestive Heart Failure", :], :HADM_ID, df -> maximum(df[:elix_score]))
ARRHY = by(elix_dx[elix_dx[:elix_category] .== "Cardiac Arrhythmias", :], :HADM_ID, df -> maximum(df[:elix_score]))
VALVE = by(elix_dx[elix_dx[:elix_category] .== "Valvular Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
PULMCIRC = by(elix_dx[elix_dx[:elix_category] .== "Pulmonary Circulation Disorders", :], :HADM_ID, df -> maximum(df[:elix_score]))
PVD = by(elix_dx[elix_dx[:elix_category] .== "Peripheral Vascular Disorders", :], :HADM_ID, df -> maximum(df[:elix_score]))
HTN = by(elix_dx[elix_dx[:elix_category] .== "Hypertension, Uncomplicated", :], :HADM_ID, df -> maximum(df[:elix_score]))
HTNCX = by(elix_dx[elix_dx[:elix_category] .== "Hypertension, Complicated", :], :HADM_ID, df -> maximum(df[:elix_score]))
PARA = by(elix_dx[elix_dx[:elix_category] .== "Paralysis", :], :HADM_ID, df -> maximum(df[:elix_score]))
NEURO = by(elix_dx[elix_dx[:elix_category] .== "Other Neurologic Disorders", :], :HADM_ID, df -> maximum(df[:elix_score]))
CHRNLUNG = by(elix_dx[elix_dx[:elix_category] .== "Chronic Pulmonary Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
DM = by(elix_dx[elix_dx[:elix_category] .== "Diabetes", :], :HADM_ID, df -> maximum(df[:elix_score]))
DMCX = by(elix_dx[elix_dx[:elix_category] .== "Diabetes with Complications", :], :HADM_ID, df -> maximum(df[:elix_score]))
HYPOTHY = by(elix_dx[elix_dx[:elix_category] .== "Hypothyroidism", :], :HADM_ID, df -> maximum(df[:elix_score]))
RENLFAIL = by(elix_dx[elix_dx[:elix_category] .== "Renal Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
LIVER = by(elix_dx[elix_dx[:elix_category] .== "Liver Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
ULCER = by(elix_dx[elix_dx[:elix_category] .== "Peptic Ulcer Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
AIDS = by(elix_dx[elix_dx[:elix_category] .== "AIDS/HIV", :], :HADM_ID, df -> maximum(df[:elix_score]))
LYMPH = by(elix_dx[elix_dx[:elix_category] .== "Lymphoma", :], :HADM_ID, df -> maximum(df[:elix_score]))
METS = by(elix_dx[elix_dx[:elix_category] .== "Metastatic Tumor", :], :HADM_ID, df -> maximum(df[:elix_score]))
TUMOR = by(elix_dx[elix_dx[:elix_category] .== "Malignancy", :], :HADM_ID, df -> maximum(df[:elix_score]))
ARTH = by(elix_dx[elix_dx[:elix_category] .== "Rheumatic Disease", :], :HADM_ID, df -> maximum(df[:elix_score]))
COAG = by(elix_dx[elix_dx[:elix_category] .== "Coagulopathy", :], :HADM_ID, df -> maximum(df[:elix_score]))
OBESE = by(elix_dx[elix_dx[:elix_category] .== "Obesity", :], :HADM_ID, df -> maximum(df[:elix_score]))
WGHTLOSS = by(elix_dx[elix_dx[:elix_category] .== "Weight Loss", :], :HADM_ID, df -> maximum(df[:elix_score]))
LYTES = by(elix_dx[elix_dx[:elix_category] .== "Fluid and Electrolye Disorders", :], :HADM_ID, df -> maximum(df[:elix_score]))
BLDLOSS = by(elix_dx[elix_dx[:elix_category] .== "Blood Loss Anemia", :], :HADM_ID, df -> maximum(df[:elix_score]))
ANEMDEF = by(elix_dx[elix_dx[:elix_category] .== "Defiency Anemia", :], :HADM_ID, df -> maximum(df[:elix_score]))
ALCOHOL = by(elix_dx[elix_dx[:elix_category] .== "Alcohol Abuse", :], :HADM_ID, df -> maximum(df[:elix_score]))
DRUG = by(elix_dx[elix_dx[:elix_category] .== "Drug Abuse", :], :HADM_ID, df -> maximum(df[:elix_score]))
PSYCH = by(elix_dx[elix_dx[:elix_category] .== "Psychoses", :], :HADM_ID, df -> maximum(df[:elix_score]))
DEPRESS = by(elix_dx[elix_dx[:elix_category] .== "Depression", :], :HADM_ID, df -> maximum(df[:elix_score]))

# relabel each category from by function output
rename!(CHF, :x1, :CHF)
rename!(ARRHY, :x1, :ARRHY)
rename!(VALVE, :x1, :VALVE)
rename!(PULMCIRC, :x1, :PULMCIRC)
rename!(PVD, :x1, :PVD)
rename!(HTN, :x1, :HTN)
rename!(HTNCX, :x1, :HTNCX)
rename!(PARA, :x1, :PARA)
rename!(NEURO, :x1, :NEURO)
rename!(CHRNLUNG, :x1, :CHRNLUNG)
rename!(DM, :x1, :DM)
rename!(DMCX, :x1, :DMCX)
rename!(HYPOTHY, :x1, :HYPOTHY)
rename!(RENLFAIL, :x1, :RENLFAIL)
rename!(LIVER, :x1, :LIVER)
rename!(ULCER, :x1, :ULCER)
rename!(AIDS, :x1, :AIDS)
rename!(LYMPH, :x1, :LYMPH)
rename!(METS, :x1, :METS)
rename!(TUMOR, :x1, :TUMOR)
rename!(ARTH, :x1, :ARTH)
rename!(COAG, :x1, :COAG)
rename!(OBESE, :x1, :OBESE)
rename!(WGHTLOSS, :x1, :WGHTLOSS)
rename!(LYTES, :x1, :LYTES)
rename!(BLDLOSS, :x1, :BLDLOSS)
rename!(ANEMDEF, :x1, :ANEMDEF)
rename!(ALCOHOL, :x1, :ALCOHOL)
rename!(DRUG, :x1, :DRUG)
rename!(PSYCH, :x1, :PSYCH)
rename!(DEPRESS, :x1, :DEPRESS)

# create a master table with all of the values in a row for a single hospitalization using joins
elix_master_table = join(DEPRESS, PSYCH, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, DRUG, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, ALCOHOL, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, ANEMDEF, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, BLDLOSS, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, LYTES, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, WGHTLOSS, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, OBESE, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, COAG, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, ARTH, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, TUMOR, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, METS, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, LYMPH, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, AIDS, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, ULCER, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, LIVER, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, RENLFAIL, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, HYPOTHY, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, DMCX, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, DM, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, CHRNLUNG, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, NEURO, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, PARA, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, HTNCX, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, HTN, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, PVD, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, PULMCIRC, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, VALVE, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, ARRHY, on = :HADM_ID, kind = :outer)
elix_master_table = join(elix_master_table, CHF, on = :HADM_ID, kind = :outer)


# add in the admissions data (ethnicity, demographics, etc)
elix_master_table = join(elix_admissions, elix_master_table, on = :HADM_ID, kind = :left)
display(elix_master_table)


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
recode!(elix_master_table, :CHF, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :ARRHY, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :VALVE, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :PULMCIRC, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :PVD, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :HTN, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :HTNCX, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :PARA, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :NEURO, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :CHRNLUNG, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :DM, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :DMCX, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :HYPOTHY, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :RENLFAIL, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :LIVER, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :ULCER, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :AIDS, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :LYMPH, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :METS, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :TUMOR, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :ARTH, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :COAG, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :OBESE, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :WGHTLOSS, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :LYTES, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :BLDLOSS, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :ANEMDEF, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :ALCOHOL, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :DRUG, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :PSYCH, Dict(NA => 0, 1 => 1), Int)
recode!(elix_master_table, :DEPRESS, Dict(NA => 0, 1 => 1), Int)

# sum the various elix categories
elix_master_table[:elix_sum] = elix_master_table[:CHF] + elix_master_table[:ARRHY] + elix_master_table[:VALVE] + elix_master_table[:PULMCIRC] + elix_master_table[:PVD] + elix_master_table[:HTN] + elix_master_table[:HTNCX] + elix_master_table[:PARA] + elix_master_table[:NEURO] + elix_master_table[:CHRNLUNG] + elix_master_table[:DM] + elix_master_table[:DMCX] + elix_master_table[:HYPOTHY] + elix_master_table[:RENLFAIL] + elix_master_table[:LIVER] + elix_master_table[:ULCER] + elix_master_table[:AIDS] + elix_master_table[:LYMPH] + elix_master_table[:METS] + elix_master_table[:TUMOR] + elix_master_table[:ARTH] + elix_master_table[:COAG] + elix_master_table[:OBESE] + elix_master_table[:WGHTLOSS] + elix_master_table[:LYTES] + elix_master_table[:BLDLOSS] + elix_master_table[:ANEMDEF] + elix_master_table[:ALCOHOL] + elix_master_table[:DRUG] + elix_master_table[:PSYCH] + elix_master_table[:DEPRESS]

display(elix_master_table)
describe(elix_master_table)

# select the columns insterested in
elix_master_table = elix_master_table[:, [:HADM_ID, :SUBJECT_ID, :CHF, :ARRHY, :VALVE, :PULMCIRC, :PVD, :HTN, :HTNCX, :PARA, :NEURO, :CHRNLUNG, :DM, :DMCX, :HYPOTHY, :RENLFAIL, :LIVER, :ULCER, :AIDS, :LYMPH, :METS, :TUMOR, :ARTH, :COAG, :OBESE, :WGHTLOSS, :LYTES, :BLDLOSS, :ANEMDEF, :ALCOHOL, :DRUG, :PSYCH, :DEPRESS, :elix_sum, :HOSPITAL_EXPIRE_FLAG]]

# writeout of table
CSV.write("elix_score.csv", elix_master_table)
