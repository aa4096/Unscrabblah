class Methods

  TEACHERSORSTUDENTS = {
    :question => "Are you a <teacher> or a <student>?",
    :valid_responses => [
      {
        :response => "teacher",
        :methods => [
          {
            :method => "GetWordsAndPrintShuffled",
            :args => "my_words.txt",
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
      }
    ],
    :error => "\nOops! You entered an invalid response.\n\n"
  }

  FILEORINPUT = {
    :question => "\nWould you like to use a text <file> or <input> each word?",
    :valid_responses => [
      {
        :response => "file",
        :methods => [
          {
            :method => "GetWordsFromFile",
            :args => "my_words.txt",
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
    :error => "\nOops! You entered an invalid response.\n\n"
  }

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

  def RunMethodsOnResponses(input)
    valid_response = nil
    if valid_response == nil || valid_response == false
      loop do
        puts input[:question]
        response = gets.downcase.chomp
        responses = []
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
                  else
                    return send(method[:method])
                  end
                  break
              end
            end
          end
          break
        else
          valid_response = false
          puts input[:error]
          sleep $sleep
        end
      end
    end
  end

  def GetWordsAndPrintShuffled(file)
    words = GetWordsFromUser(file)
    PrintShuffledWords(words)
  end

  def StartProgram()
    RunMethodsOnResponses(Methods::TEACHERSORSTUDENTS)
  end

  def StartGame()
    LoadingPrompt("Game Starting",4)
    words = GetWordsFromFile("english_words.txt")
    puts words
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