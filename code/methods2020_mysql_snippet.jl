# methods2020_mysql_snippet.jl
# MySQL snippet
#
# MySQL package
# https://github.com/JuliaDatabases/MySQL.jl
#
# DataFrames package
# https://github.com/JuliaData/DataFrames.jl
# https://juliadata.github.io/DataFrames.jl/stable/
# https://en.wikibooks.org/wiki/Introducing_Julia/DataFrames
#
# CSV package
# https://juliadata.github.io/CSV.jl/stable/

using MySQL
using DataFrames
using CSV

# get basic connection variables (DB_NAME, QUERY, and CSV_PATH should be changed depending on your desired table)
DB_HOST = "pursamydbcit.services.brown.edu"
DB_NAME = "mimiciiiv14"
QUERY = "SELECT ADMISSION_TYPE, INSURANCE, ETHNICITY, DIAGNOSIS FROM ADMISSIONS LIMIT 10;"
CSV_PATH = "/Users/your_computer/methods2020/methods2020_my_final_project/data/admissions_info.csv"

# function for getting password (not shown)
function get_pass(msg::String = "")
    if isempty(msg)
        msg = "Enter password: "
    end 
    cstring = ccall(:getpass, Cstring, (Cstring,), msg)
    ptr = pointer(cstring)
    pswd = unsafe_string(ptr)
    return pswd
end

# ask user for username
print("Enter username: ")
db_user = readline()

# ask user to type in password
db_password = get_pass()

# create connection
db_connection = MySQL.connect(DB_HOST, db_user, db_password; db = "$DB_NAME", opts=Dict(MySQL.API.MYSQL_ENABLE_CLEARTEXT_PLUGIN=>"true"))

# get results as a DataFrame (tabular data structure)
query_results_df = MySQL.Query(db_connection, QUERY) |>  DataFrame

# close the MySQL connection
MySQL.disconnect(db_connection)

# print out the size, number of rows and columns of the result set
println("size = $(size(query_results_df))")
println("rows = $(size(query_results_df, 1))")
println("columns = $(size(query_results_df, 2))")

# give basic description of columns in result set
describe(query_results_df)

# save the dataframe to a CSV
CSV.write(CSV_PATH, query_results_df)
