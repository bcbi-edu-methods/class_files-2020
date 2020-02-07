
# my first julia program

#=

# introduce script
println("hello, welcome to my first scriot!")

# ask user if having a nice day
print("are you having a nice day: ")

# get response
user_response = readline(stdin)

# tell use what they said
println("I'm happy you said \"$user_response\"")

=#

# ask use for a number (Int64 or Float64)
print("what is your favorite number? ")
fav_number = parse(Int64, readline(stdin))

# ask user for favorite number
println("I really like the number $fav_number")

# double and half the number
double_fav_number = fav_number * 2
half_fav_number = fav_number / 2

# report the results
println("but I really like twice that: $double_fav_number")
println("not sure how I feel about half your number: $half_fav_number")

# apply if-elseif-else rules
if double_fav_number > 50

    println("double your number is more than 50")

elseif double_fav_number < 50

    println("double your number is less than 50")

else

    println("your number must be 50")

end














#


