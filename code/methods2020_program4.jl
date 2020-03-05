
# process the BRFSS file and report some cool statistics

#println("hello! this my awesome program for reading in files!")

# open input file
input_file = open("/Users/insarkar/methods2020/class_files-2020/data/brfss/brfss_ri_2018.txt", "r")

# create a dictionary for asthma values
asthma_dx_dict = Dict()
asthma_dx_dict["1"]  = "Yes"
asthma_dx_dict["2"]  = "No"
asthma_dx_dict["7"]  = "Dunno"
asthma_dx_dict["9"]  = "I don't like you"
asthma_dx_dict[" "]  = "I am ignoring you"

# create dictionary to keep track of counts
asthma_dx_count_dict = Dict()

# read in each line of the input file
for line in readlines(input_file)

    #println(line)

    asthma_dx_value = string(line[107])

    # keep track of number of times each dx value occurs
    if haskey(asthma_dx_count_dict, asthma_dx_value)
        asthma_dx_count_dict[asthma_dx_value] += 1
    else
        asthma_dx_count_dict[asthma_dx_value] = 1
    end



end


# report out the counts
for key in sort(collect(keys(asthma_dx_count_dict)), rev = false)

    print_value = asthma_dx_dict[key]
    println("\"$print_value\" occurs $(asthma_dx_count_dict[key]) times")

end

# create output file
output_file = open("methods2020_program4_output.txt", "w")

# report out the counts, sorted by value
for (count, response) in sort(collect(zip(values(asthma_dx_count_dict), keys(asthma_dx_count_dict))), rev=false)

    print_response = asthma_dx_dict[response]
    println("$print_response occurs $count times!")
    write(output_file, "$print_response occurs $count times!\n")

end
