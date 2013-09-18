require 'net/http'

url = 'http://randomword.setgetgo.com/get.php'
resp = Net::HTTP.get_response(URI.parse(url))

word = resp.body
len = word.length

puts "To guess a character, type that single character... If you think you know the word, then type the whole word."
puts "Type 'I give' to see the word"
puts "Okay lets begin... \nYour word is #{len} characters long."

masked = "_" * len
puts masked

guess_count = 0

original_word = word

word = word.split(//)
masked = masked.split(//)

while masked.include? "_" do
    puts "Guess a letter:"
    guess = gets.strip!
    
    if guess.downcase == "i give"
        break
    elsif guess.length == 1
        if word.include? guess
            word.each_with_index do |word_char, i|
                if word_char == guess
                    masked.delete_at(i)
                    masked.insert(i, word_char)
                end
            end
        elsif guess == original_word
        break
        end
    end
    print masked.join('')
    
    guess_count += 1
    puts "\nNumber of guesses so far: #{guess_count} ...try again"
end

print "The word is " + original_word
