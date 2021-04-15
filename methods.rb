class Methods

  ERROR_MESSAGE = "\nOops! You entered an invalid response.\n\n"
  MYWORDS = "my_words.txt"

  # Hash properties for questions.
  # Sets each question's valid responses and runs the appropriate methods with
  # arguments upon valid response. Throws error upon invalid responses.
  TEACHERSORSTUDENTS = {
    :question => "Are you a <teacher> or a <student>?",
    :type => "string",
    :valid_responses => [
      {
        :response => "teacher",
        :methods => [
          {
            :method => "StartTool",
            :args => Methods::MYWORDS
          }
        ]
      },
      {
        :response => "student",
        :methods => [
          {
            :method => "StartGame",
          }
        ]
      },
      {
        :response => "developer",
        :methods => [
          {
            :method => "StartGame",
          }
        ]
      }
    ],
    :error => Methods::ERROR_MESSAGE
  }

  FILEORINPUT = {
    :words_file => "my_words.txt",
    :type => "string",
    :question => "\nWould you like to use a text <file> or <input> each word?",
    :valid_responses => [
      {
        :response => "file",
        :methods => [
          {
            :method => "GetWordsFromFile",
            :args => Methods::MYWORDS
          }
        ]
      },
      {
        :response => "input",
        :methods => [
          {
            :method => "GetWordsFromInput",
          }
        ]
      }
    ],
    :error => Methods::ERROR_MESSAGE
  }

  CHOOSEDIFFICULTY = {
    :question => "\nWould you like to play on <easy>, <medium>, or <hard>?",
    :type => "string",
    :valid_responses => [
      {
        :response => "easy",
        :methods => [
          {
            :method => "SetDifficulty",
            :args => "easy"
          }
        ]
      },
      {
        :response => "medium",
        :methods => [
          {
            :method => "SetDifficulty",
            :args => "medium"
          }
        ]
      },
      {
        :response => "hard",
        :methods => [
          {
            :method => "SetDifficulty",
            :args => "hard"
          }
        ]
      }
    ],
    :error => Methods::ERROR_MESSAGE
  }

  SETNUMBEROFWORDS = {
    :question => "How many words would you like to unscramble? Enter a positive whole number between 1 and 99.",
    :type => "int",
    :send_response => true,
    :methods => [
      {
        :method => "SetNumberOfWords",
      }
    ],
    :error => Methods::ERROR_MESSAGE
  }

  def URLFriendlyWord(word)
    output = word.gsub(/\s/,'%20')
    return output
  end

  def PingWebster(word)
    query = {}
    body = {}
    options = {}

    url_friendly_word = URLFriendlyWord(word)

    begin
      response = HTTParty.post("https://www.dictionaryapi.com/api/v3/references/sd2/json/#{url_friendly_word}?key=#{$api_key}")

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

  def GetWordsFromFile(file)
    words = []
    begin
      file = File.foreach(file) { |line| words << line.chomp }
      return words
    rescue
      puts "Error: Make sure there that \"#{file}\" exists and contains an entry list of words."
      exit
    end
  end

  def RunMethodsOnResponses(input)
    valid_response = nil
    if valid_response == nil || valid_response == false
      loop do

        # Print the question and grab the response from the user.
        puts input[:question]
        response = gets.downcase.chomp
        responses = []

        # Print Response if Debug Mode is enabled.
        if $debug == true
          puts "Response: #{response}"
        end

        # Check if expected response is a string or integer.
        # Check if the response is one of the valid responses.
        # Run the specified method with arguments for each valid response.
        if input[:type] == "string"
          input[:valid_responses].each do |valid_response|
            responses << valid_response[:response]
          end
          if responses.include?(response) == true
            input[:valid_responses].each do |valid_response|
              if valid_response[:response] == response
                valid_response[:methods].each do |method|
                    valid_response = true
                    if method[:args]
                      return send(method[:method],method[:args])
                    elsif input[:send_response] == true
                      return send(method[:method],response)
                    else
                      return send(method[:method])
                    end
                    break
                  end
                end
              end
            break
          else
            # Print error on invalid response, then loop back for the user to try again.
            valid_response = false
            puts input[:error]
            sleep $sleep
          end
        elsif input[:type] == "int"
          regex = /^(\d+)$/
          if response =~ regex
            response = response.to_i
            if response <= 99
              input[:methods].each do |method|
                if method[:args]
                  return send(method[:method],method[:args])
                elsif input[:send_response] == true
                  return send(method[:method],"#{response}")
                else
                  return send(method[:method])
                end
                break
              end
            end
          else
            valid_response = false
            puts input[:error]
            sleep $sleep
          end
        end
      end
    end
  end

  def GetWordsFromUser(file)
    RunMethodsOnResponses(Methods::FILEORINPUT)
  end

  def GetWordsFromUser(file)
    RunMethodsOnResponses(Methods::FILEORINPUT)
  end

  def GetWordsFromUser(file)
    RunMethodsOnResponses(Methods::FILEORINPUT)
  end

  def GetWordsFromInput()
    puts "\n\Type each of your words and hit Enter. Type <done> when you are finished entering words:"
    user_words = []

    loop do
      user_word = gets.downcase.chomp
      if user_word == "done"
        break
      end
      user_words << user_word
    end

    words = user_words
    return words
  end

  def ShuffleWords(words)
    words_array = []
    word_hashes = []
    word_hash = {}

    words.each do |word|
      word_hash = {}
      word_array = []
      word = word
      word_hash[:word] = word
      definitions = PingWebster(word)
      word_hash[:definitions] = definitions

      word.each_char { |letter|
        word_array << letter
      }

      word_array = word_array.shuffle
      word_hash[:shuffled] = word_array.join
      word_hashes << word_hash
    end

    return word_hashes
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
          word = URLFriendlyWord(word[:word])
          print "Definition: https://www.merriam-webster.com/dictionary/#{word}\n"
        end
      end
      puts "\n---\n\n"
    end
    sleep $sleep
    puts "\nThank you for using Unscrabblah!\n\n"
  end

  def GetWordsAndPrintShuffled(file)
    words = GetWordsFromUser(file)
    PrintShuffledWords(words)
  end

  def StartTool(file)
    GetWordsAndPrintShuffled(file)
  end

  def StartProgram()
    RunMethodsOnResponses(Methods::TEACHERSORSTUDENTS)
  end

  def ChooseDifficulty()
    RunMethodsOnResponses(Methods::CHOOSEDIFFICULTY)
  end

  def SetDifficulty(difficulty)
    words = GetWordsFromFile("english_words.txt")
    words_by_difficulty = GrabWordsBasedOnDifficulty(difficulty,words)
    words_by_number = RunMethodsOnResponses(Methods::SETNUMBEROFWORDS)
  end

  def GrabWordsBasedOnDifficulty(difficulty,words)
    difficulties = {
      :easy => [0,5],
      :medium => [6,10],
      :hard => [11,-1],
    }

    difficulty_floor = difficulties[difficulty.to_sym][0].to_int
    if difficulties[difficulty.to_sym][1].to_int == -1
      difficulty_ceiling = Float::INFINITY
    else
      difficulty_ceiling = difficulties[difficulty.to_sym][1].to_int
    end

    selected_words = words.select do |word|
      word.length >= difficulty_floor
    end

    selected_words = selected_words.select do |word|
      word.length <= difficulty_ceiling
    end

    return selected_words
  end

  def SetNumberOfWords(number)
    return "Number is #{number}."
  end

  def StartGame()
    LoadingPrompt("Game Starting",4)
    words = GetWordsFromFile("english_words.txt")
    ChooseDifficulty()
    exit
  end

  def LoadingPrompt(string,time_in_seconds)
    print "\n#{string}"
    i = 0
    while i < time_in_seconds do
      sleep $sleep
      print "."
      i+=1
    end
    sleep $sleep
    puts " Ready!"
  end
end

class RunProgram

  @@my_words = []

  def initialize
    @@my_words = Methods.new.GetWordsFromFile("my_words.txt")
    if $debug == true
      print "@@my_words: #{@@my_words}\n\n"
    end
  end

end