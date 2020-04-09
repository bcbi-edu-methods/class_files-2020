# methods2020_program5.jl
# DataFrames
# Created: 2020-04-02
# Updated: 2020-04-07

using DataFrames
using CSV

# load data into DataFrames
# For Mac
a_df = CSV.File("/Users/eschen/methods2020/class_files-2020/data/mimic_demo/ADMISSIONS.csv", header = 1, footerskip = 0) |> DataFrame

# For Windows
# a_df = CSV.File("C:\\Users\\eschen\\methods2020\\class_files-2020\\data\\mimic_demo\\ADMISSIONS.csv", header = 1, footerskip = 0) |> DataFrame

# describe and show first two lines
println(describe(a_df))
println(first(a_df, 2))

filtered_a_df = a_df[a_df.hospital_expire_flag .== 1, [:subject_id, :hadm_id, :insurance, :hospital_expire_flag]]
println(filtered_a_df)
println(describe(filtered_a_df))

# write to output File
CSV.write("/Users/eschen/methods2020/work-files-2020-eschen/code/echen13_program5_output.txt", filtered_a_df)
# CSV.write("C:\\Users\\eschen\\methods2020\\work-files-2020-eschen\\code\\echen13_program5_output.txt", filtered_a_df)

### Output
#=
$ julia echen13_program5.jl

19×8 DataFrame
│ Row │ variable             │ mean     │ min                                                                                                                   │ median   │ max                       │ nunique │ nmissing │ eltype                 │
│     │ Symbol               │ Union…   │ Any                                                                                                                   │ Union…   │ Any                       │ Union…  │ Union…   │ Type                   │
├─────┼──────────────────────┼──────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────┼───────────────────────────┼─────────┼──────────┼────────────────────────┤
│ 1   │ row_id               │ 28036.4  │ 12258                                                                                                                 │ 39869.0  │ 41092                     │         │          │ Int64                  │
│ 2   │ subject_id           │ 28010.4  │ 10006                                                                                                                 │ 40310.0  │ 44228                     │         │          │ Int64                  │
│ 3   │ hadm_id              │ 152343.0 │ 100375                                                                                                                │ 157235.0 │ 199395                    │         │          │ Int64                  │
│ 4   │ admittime            │          │ 2102-08-29 07:15:00                                                                                                   │          │ 2202-10-03 01:45:00       │ 129     │          │ String                 │
│ 5   │ dischtime            │          │ 2102-09-06 16:20:00                                                                                                   │          │ 2202-10-11 16:30:00       │ 129     │          │ String                 │
│ 6   │ deathtime            │          │ 2105-06-11 02:20:00                                                                                                   │          │ 2192-05-15 19:28:00       │ 40      │ 89       │ Union{Missing, String} │
│ 7   │ admission_type       │          │ ELECTIVE                                                                                                              │          │ URGENT                    │ 3       │          │ String                 │
│ 8   │ admission_location   │          │ CLINIC REFERRAL/PREMATURE                                                                                             │          │ TRANSFER FROM SKILLED NUR │ 5       │          │ String                 │
│ 9   │ discharge_location   │          │ DEAD/EXPIRED                                                                                                          │          │ SNF                       │ 10      │          │ String                 │
│ 10  │ insurance            │          │ Government                                                                                                            │          │ Private                   │ 4       │          │ String                 │
│ 11  │ language             │          │ ENGL                                                                                                                  │          │ SPAN                      │ 5       │ 48       │ Union{Missing, String} │
│ 12  │ religion             │          │ BUDDHIST                                                                                                              │          │ UNOBTAINABLE              │ 10      │ 1        │ Union{Missing, String} │
│ 13  │ marital_status       │          │ DIVORCED                                                                                                              │          │ WIDOWED                   │ 6       │ 16       │ Union{Missing, String} │
│ 14  │ ethnicity            │          │ AMERICAN INDIAN/ALASKA NATIVE FEDERALLY RECOGNIZED TRIBE                                                              │          │ WHITE                     │ 9       │          │ String                 │
│ 15  │ edregtime            │          │ 2104-09-24 12:07:00                                                                                                   │          │ 2202-10-03 01:19:00       │ 92      │ 37       │ Union{Missing, String} │
│ 16  │ edouttime            │          │ 2104-09-24 18:50:00                                                                                                   │          │ 2202-10-03 03:40:00       │ 92      │ 37       │ Union{Missing, String} │
│ 17  │ diagnosis            │          │  MITRAL REGURGITATION;CORONARY ARTERY DISEASE\\CORONARY ARTERY BYPASS GRAFT WITH MVR  ? MITRAL VALVE REPLACEMENT /SDA │          │ VOLVULUS                  │ 95      │          │ String                 │
│ 18  │ hospital_expire_flag │ 0.310078 │ 0                                                                                                                     │ 0.0      │ 1                         │         │          │ Int64                  │
│ 19  │ has_chartevents_data │ 0.992248 │ 0                                                                                                                     │ 1.0      │ 1                         │         │          │ Int64                  │

2×19 DataFrame
│ Row │ row_id │ subject_id │ hadm_id │ admittime           │ dischtime           │ deathtime           │ admission_type │ admission_location        │ discharge_location │ insurance │ language │ religion │ marital_status │ ethnicity              │ edregtime           │ edouttime           │ diagnosis   │ hospital_expire_flag │ has_chartevents_data │
│     │ Int64  │ Int64      │ Int64   │ String              │ String              │ String⍰             │ String         │ String                    │ String             │ String    │ String⍰  │ String⍰  │ String⍰        │ String                 │ String⍰             │ String⍰             │ String      │ Int64                │ Int64                │
├─────┼────────┼────────────┼─────────┼─────────────────────┼─────────────────────┼─────────────────────┼────────────────┼───────────────────────────┼────────────────────┼───────────┼──────────┼──────────┼────────────────┼────────────────────────┼─────────────────────┼─────────────────────┼─────────────┼──────────────────────┼──────────────────────┤
│ 1   │ 12258  │ 10006      │ 142345  │ 2164-10-23 21:09:00 │ 2164-11-01 17:15:00 │ missing             │ EMERGENCY      │ EMERGENCY ROOM ADMIT      │ HOME HEALTH CARE   │ Medicare  │ missing  │ CATHOLIC │ SEPARATED      │ BLACK/AFRICAN AMERICAN │ 2164-10-23 16:43:00 │ 2164-10-23 23:00:00 │ SEPSIS      │ 0                    │ 1                    │
│ 2   │ 12263  │ 10011      │ 105331  │ 2126-08-14 22:32:00 │ 2126-08-28 18:59:00 │ 2126-08-28 18:59:00 │ EMERGENCY      │ TRANSFER FROM HOSP/EXTRAM │ DEAD/EXPIRED       │ Private   │ missing  │ CATHOLIC │ SINGLE         │ UNKNOWN/NOT SPECIFIED  │ missing             │ missing             │ HEPATITIS B │ 1                    │ 1                    │

40×4 DataFrame
│ Row │ subject_id │ hadm_id │ insurance  │ hospital_expire_flag │
│     │ Int64      │ Int64   │ String     │ Int64                │
├─────┼────────────┼─────────┼────────────┼──────────────────────┤
│ 1   │ 10011      │ 105331  │ Private    │ 1                    │
│ 2   │ 10013      │ 165520  │ Medicare   │ 1                    │
│ 3   │ 10019      │ 177759  │ Medicare   │ 1                    │
│ 4   │ 10036      │ 189483  │ Medicare   │ 1                    │
│ 5   │ 10045      │ 126949  │ Medicare   │ 1                    │
│ 6   │ 10059      │ 122098  │ Medicare   │ 1                    │
│ 7   │ 10064      │ 111761  │ Medicare   │ 1                    │
│ 8   │ 10067      │ 160442  │ Private    │ 1                    │
│ 9   │ 10069      │ 146672  │ Medicaid   │ 1                    │
│ 10  │ 10076      │ 198503  │ Medicare   │ 1                    │
│ 11  │ 10089      │ 190301  │ Medicare   │ 1                    │
│ 12  │ 10093      │ 165393  │ Medicare   │ 1                    │
│ 13  │ 10094      │ 122928  │ Medicare   │ 1                    │
│ 14  │ 10098      │ 180685  │ Private    │ 1                    │
│ 15  │ 10101      │ 142539  │ Government │ 1                    │
│ 16  │ 10102      │ 164869  │ Medicare   │ 1                    │
│ 17  │ 10111      │ 174739  │ Medicare   │ 1                    │
│ 18  │ 10112      │ 188574  │ Medicare   │ 1                    │
│ 19  │ 10117      │ 105150  │ Private    │ 1                    │
│ 20  │ 10120      │ 193924  │ Medicaid   │ 1                    │
│ 21  │ 10124      │ 170883  │ Medicare   │ 1                    │
│ 22  │ 10126      │ 160445  │ Private    │ 1                    │
│ 23  │ 40177      │ 198480  │ Medicare   │ 1                    │
│ 24  │ 40310      │ 157609  │ Medicaid   │ 1                    │
│ 25  │ 40503      │ 168803  │ Medicare   │ 1                    │
│ 26  │ 40687      │ 129273  │ Medicare   │ 1                    │
│ 27  │ 41983      │ 107689  │ Medicare   │ 1                    │
│ 28  │ 42033      │ 154156  │ Medicare   │ 1                    │
│ 29  │ 42066      │ 171628  │ Private    │ 1                    │
│ 30  │ 42075      │ 151323  │ Medicare   │ 1                    │
│ 31  │ 42135      │ 117105  │ Medicaid   │ 1                    │
│ 32  │ 42281      │ 195911  │ Medicare   │ 1                    │
│ 33  │ 42346      │ 175880  │ Medicare   │ 1                    │
│ 34  │ 42367      │ 139932  │ Medicare   │ 1                    │
│ 35  │ 42430      │ 100969  │ Medicare   │ 1                    │
│ 36  │ 43735      │ 112662  │ Medicare   │ 1                    │
│ 37  │ 43746      │ 167181  │ Medicare   │ 1                    │
│ 38  │ 43870      │ 142633  │ Medicare   │ 1                    │
│ 39  │ 43909      │ 167612  │ Medicare   │ 1                    │
│ 40  │ 44154      │ 174245  │ Medicare   │ 1                    │

4×8 DataFrame
│ Row │ variable             │ mean     │ min        │ median   │ max     │ nunique │ nmissing │ eltype   │
│     │ Symbol               │ Union…   │ Any        │ Union…   │ Any     │ Union…  │ Nothing  │ DataType │
├─────┼──────────────────────┼──────────┼────────────┼──────────┼─────────┼─────────┼──────────┼──────────┤
│ 1   │ subject_id           │ 24563.8  │ 10011      │ 10122.0  │ 44154   │         │          │ Int64    │
│ 2   │ hadm_id              │ 154951.0 │ 100969     │ 162657.0 │ 198503  │         │          │ Int64    │
│ 3   │ insurance            │          │ Government │          │ Private │ 4       │          │ String   │
│ 4   │ hospital_expire_flag │ 1.0      │ 1          │ 1.0      │ 1       │         │          │ Int64    │
=#
