# methods2020_program5.jl
# DataFrames
# Created: 2020-04-02

# load packages
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

=#
