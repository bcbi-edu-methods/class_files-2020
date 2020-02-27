# program 3: arrays, sets, and dictionaries-- oh my!

# ask user for a phrase
println("enter phrase")
phrase = readline(stdin)

println("you said: $phrase")

# tell the user the length and what the first three characters are
println("length of phrase is: $(length(phrase))")
println("first three characters are: $(phrase[1:3])")

# create word array
#word_array = []
word_array = split(phrase, " ")

for word_num in 1:length(word_array)
    println("<array> word $word_num in phrase is $(word_array[word_num])")
end


# load the array into a set
word_set = Set()
for word in word_array
    push!(word_set, word)
end

# print out the contents of the set
for word in word_set
    println("<set> word in phrase is: $word")
end


translated_dict = Dict()
translated_dict["wheels"] = "tyres"
translated_dict["bus"]    = "coach"

for word in word_array
    
    if haskey(translated_dict, word)
        println("$word translates to $(translated_dict[word])")
    else
        println("$word stays the same...")
    end

end

##### BEGIN CLASS EXERCISE
## Until the user types "stop,stop", ask the user for translations as key, value
## pairs that will be used to convert phrases later. Then:
##		(1) Reports the keys in the order that they were entered
##		(2) Reports the unique list of keys
##		(3) Asks the user for 3 words to translate, and reports the translation



























