# program 3: arrays, sets, and dictionaries-- oh my!

#=
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

=#

##### BEGIN CLASS EXERCISE
## Until the user types "stop,stop", ask the user for translations as key, value
## pairs that will be used to convert phrases later. Then:
##		(1) Reports the keys in the order that they were entered
##		(2) Reports the unique list of keys
##		(3) Asks the user for 3 words to translate, and reports the translation

key_val_pair = ""
translate_dict = Dict()
key_array = []
key_set = Set()

print("enter a translation (as \"key,value\"): ")
key_val_pair = readline(stdin)

while key_val_pair != "stop,stop"

	key_val_array = split(key_val_pair, ",")

	key = key_val_array[1]
	val = key_val_array[2]

	push!(key_array, key)
	push!(key_set, key)

	translate_dict[key] = val
	print("enter a translation (as \"key,value\"): ")
	global key_val_pair = readline(stdin)
end

println("thanks. The order that keys were entered was:")
for key in key_array
	println(key)
end

println("\nwhich consisted of the following unique keys:")
for key in key_set
	println(key)
end

for word_count in 1:3
	print("give me a word/phrase to translate ($word_count): ")
	translate_phrase = readline(stdin)

	if haskey(translate_dict, translate_phrase)
		translation = translate_dict[translate_phrase]
		println("that translates to: $translation")
	else
		println("no translation available")
	end

end


























