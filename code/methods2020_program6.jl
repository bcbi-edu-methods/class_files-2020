# http://archive.ics.uci.edu/ml/datasets/iris
# https://github.com/bensadeghi/DecisionTree.jl


using CSV
using DataFrames
using DecisionTree

using Random

println("hello, testing ML coding with this program")

iris_df = CSV.File("/Users/insarkar/methods2020/class_files-2020/data/uci/iris.data", header=0, footerskip=2) |> DataFrame
println(describe(iris_df))

# coerce features into types for performance
labels   = string.(iris_df[!,5])
features = convert(Array{Float64, 2}, iris_df[:, 1:4])

Random.seed!(42)

# train random forest classifier
model = build_forest(labels, features, 2, 10, 0.5, 6)

# apply the learned model
apply_forest(model, [8.0,5.0,1.1,8.9])

# get the probability for each label
apply_forest_proba(model, [8.0,5.0,1.1,8.9], ["Iris-setosa", "Iris-versicolor", "Iris-virginica"])

n_folds = 3
n_subfeatures = 2
accuracy = nfoldCV_forest(labels, features, n_folds,n_subfeatures)






