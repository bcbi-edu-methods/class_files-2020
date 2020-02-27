# program 2

#=
println("hello! welcome to my second program!")

print("please enter a phrase: ")
phrase = readline(stdin)

println("your phrase is \"$phrase\"")

# determine the length of the phrase
phrase_length = length(phrase)

println("the length of the phrase is $phrase_length")

if phrase_length < 10
    println("your phrase is less than 10 characters")
elseif phrase_length == 10
    println("your phrase is exactly 10 characters")
else
    println("your phrase must be at least 10 characters")
end

# get the first character, last character, and substring
first_char = phrase[1]
last_char = phrase[phrase_length]
substring = phrase[2:3]

println("first char is $first_char")
println("last char is $last_char")
println("substring is $substring")

# find words in phrase
if phrase == "hello"
    println("welcome to program")
elseif occursin("good", phrase)
    println("you said good!")
end


# while the phrase is less than 10 characters, 
# ask user for another phrase
while phrase_length < 10
    println("your phrase, $phrase, is too short")
    print("enter another phrase: ")
    global phrase = readline(stdin)
    global phrase_length = length(phrase)
end

# for every index position between a range, print out
# the characaters
for number in 5:7
    pos_character = phrase[number]
    println("character at position $number is $pos_character")
end


# Regular expression
# if the phrase contains the letters a,b,c, or d, tell user
if occursin(r"[abcd]", phrase)
    println("your phrase has a,b,c, or d!")
else
    println("your phrase does not have a,b,c, or d")
end

# identify if phrase has numbers
if occursin(r"[0-9]", phrase)
    println("your phrase has numbers!")
else
    println("your phrase does not have numbers!")
end

# look for pattern of lc, #, uc
if occursin(r"[a-z][0-9][A-Z]", phrase)
    println("your phrase has lc-#-uc pattern!")
end

=#

# write a program that asks user to enter a date
# then verify the date was entered in the correct format (mm/dd/yyyy)
# if date was entered correctly, ask user to enter another date
# note: date does not need to be valid just right format
print("enter a date: ")
user_date = readline(stdin)

while occursin(r"[01][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]", user_date)
    println("** VALID DATE **")
    print("enter another date: ")
    global user_date = readline(stdin)
end


































