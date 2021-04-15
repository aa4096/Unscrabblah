require_relative 'methods.rb'

class Tests

  methods = Methods.new
  run_program = RunProgram.new

  TESTS = [
    ["GrabWordsBasedOnDifficulty","medium"],
    ["SetNumberOfWordsTest"],
    ["StartRunProgram"],
  ]

  def GrabWordsBasedOnDifficulty(difficulty)
    test = Methods.new
    words = test.GetWordsFromFile("english_words.txt")
    return test.GrabWordsBasedOnDifficulty(difficulty,words)
  end

  def SetNumberOfWordsTest()
    test = Methods.new
    return test.RunMethodsOnResponses(Methods::SETNUMBEROFWORDS)
  end

  def StartRunProgram()
    run_program
  end

  def StartTests()
    tests = Tests::TESTS
    tests.each do |method,args|
      if args
        send(method,args)
      else
        send(method)
      end
      puts "Testing: #{method}(#{args})"
    end
    return "Tests Complete"
  end

end