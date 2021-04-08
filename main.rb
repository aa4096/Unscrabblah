#!/usr/bin/env ruby

require "httparty"

$api_key = "5f0ddd7f-7c30-4eec-bf0b-a1d02fdf9551"
$sleep = 0

$words = []

sleep $sleep
puts "\n\nUnscrabblah version 1.1"
puts "Written by: Aaron Pena"
puts "Tested by: Yvette Berlanga"
puts "Website: https://webdataiot.com"
puts "Email: aaron@webdataiot.com"

def GetWordsFromUser(file)
  @words = []

  $valid_command = nil

  if $valid_command == nil || $valid_command == false
    loop do
      sleep $sleep
      puts "\n\nWould you like to use a text <file> or <input> each word?"

      text_or_input = gets.downcase.chomp

      if text_or_input == "file"
        $valid_command = true
        begin
          file = File.foreach(file) { |line| @words << line.chomp }
        rescue
          puts "Error: Make sure there that \"words.txt\" exists and contains an entry list of words."
          exit
        end
        break
      elsif text_or_input == "input"
        $valid_command = true
        puts "\n\nEnter each of your words. Type <done> when you are finished:"
        @user_words = []

        loop do
          @user_word = gets.downcase.chomp
          if @user_word == "done"
            break
          end
          @user_words << @user_word
        end

        @words = @user_words
        break
      else
        $valid_command = false
        puts "Please enter a valid command."
        sleep $sleep
      end
    end
  end
  return @words
end

def ShuffleWords(words)
  @words_array = []
  @word_hashes = []
  @word_hash = {}

  words.each do |word|
    @word_hash = {}
    @word_array = []
    @word = word
    @word_hash[:word] = @word
    @definitions = PingWebster(@word)
    @word_hash[:definitions] = @definitions

    @word.each_char { |letter|
      @word_array << letter
    }

    @word_array = @word_array.shuffle
    @word_hash[:shuffled] = @word_array.join
    @word_hashes << @word_hash
  end

  return @word_hashes
end

def PingWebster(word)
  query = {}
  body = {}
  options = {}

  begin
    response = HTTParty.post("https://www.dictionaryapi.com/api/v3/references/sd2/json/#{word}?key=#{$api_key}")

    definitions = []
    response.each do |res|
      defined?(res["shortdef"])
      definitions << res["shortdef"]
    end
    return definitions[0]
  rescue
    print "There was an error with the word [#{word}]\n\n---\n\n"
  end
end

def PrintShuffledWords(words)
  downcase_words = []

  words.each do |word|
    downcase_words << word.downcase
  end

  words = downcase_words

  print "\nWords:\n"

  words.each do |word|
    print word + "\n"
  end

  sleep $sleep
  print "\n"
  shuffled_words = ShuffleWords(words)
  reshuffled_words = shuffled_words.shuffle

  reshuffled_words.each do |word|
    puts "Word: #{word[:word]}"
    puts "Shuffled Word: #{word[:shuffled]}"
    if word.has_key? :definitions
      if word[:definitions].nil? == false
        print "Definitions: "
        word[:definitions].each_with_index do |definition, index|
          index += 1
          print "(#{index}) " + definition.capitalize + ".\n"
        end
      else
        print "Definition: https://www.merriam-webster.com/dictionary/#{word[:word]}\n"
      end
    end
    puts "\n---\n\n"
  end
  sleep $sleep
  puts "\nThank you for using Unscrabblah!\n\n"
end

$words = GetWordsFromUser("words.txt")

PrintShuffledWords($words)