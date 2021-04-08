# Unscrabblah!

**Unscrabblah!** is a tool for educators to teach students how to unscramble letters to correctly spell vocabulary words.

```
Version: 1.1
Written by: Aaron Pena
Tested by: Yvette Berlanga
Website: https://webdataiot.com
Email: aaron@webdataiot.com
```

## How To Run

1. Visit the Unscrabblah! program on Repl.it 
   
   [Unscrabblah! - Replit](https://replit.com/@WEBDATAIOTInc/Unscrabblah)
   
   Or clone the repository from Github.
   
   `$ git clone ://github.com/aa4096/Unscrabblah.git`

2. Unscrabblah! allows you to either add vocabulary words to the `words.txt` file or enter vocabulary words one by one during run time. Choose the one that works best for you!

3. Run the program! Click "Run" on Repl.it or if you cloned the repository run:
   
   `$ cd /path/to/unscrabblah
   $ ruby main.rb`

## Example Guide

The easiest way to get started is to open the program in Repl.it.

Visit [Unscrabblah! - Replit](https://replit.com/@WEBDATAIOTInc/Unscrabblah)

Open the file `main.rb` and click `Run` at the top of the page or hit `ctrl+enter`.



You will be prompted with the program and credits in the Console.

![File or Input Prompt](https://imgur.com/2ShrDRs.png)

The console will then ask:

`Would you like to use a text <file> or <input> each word?`

Type `file` to use the vocabulary words in `words.txt` 

Or type `input` to manually enter your words.



For this example, we will type our words manually. So let's type `input`.



The Console will then prompt:

`Enter each of your words. Type <done> when you are finished:`

![Words](https://imgur.com/5wtG6WC.png)

Simple type one of your words and hit enter. Repeat this process until all of your words have been entered.



Example Words:

```
Aardvark
Lion
Elephant
Kangaroo
```



To complete this process, type `done`.



After a few seconds, the program will display your list of words with letters randomly shuffled around including the definitions for each word provided by the [Merium-Webster Dictionary API](https://dictionaryapi.com/).

Note: Sometimes the API has trouble finding the definition for the vocabulary word. In this case, the program provides a link to the online dictionary to fetch for yourself.

Example output:

![Example Output](https://imgur.com/JkzOydF.png)

```
Words:
aardvark
lion
elephant
kangaroo

Word: lion
Shuffled Word: inlo
Definitions: (1) A large meat-eating animal of the cat family that has a brownish buff coat, a tufted tail, and in the male a shaggy mane and that lives in africa and southern asia.

---

Word: elephant
Shuffled Word: etanhple
Definitions: (1) A huge typically gray mammal of africa or asia with the nose drawn out into a long trunk and two large curved tusks.

---

Word: kangaroo
Shuffled Word: kgoornaa
Definitions: (1) A leaping mammal of australia and nearby islands that feeds on plants and has long powerful hind legs, a thick tail used as a support in standing or walking, and in the female a pouch on the abdomen in which the young are carried.

---

Word: aardvark
Shuffled Word: ravaardk
Definitions: (1) An african animal with a long snout and a long sticky tongue that feeds mostly on ants and termites and is active at night.

---
```

The program will then thank you for using it.

Now you may copy and paste your output into any worksheet, quiz, or test that you'd like.

And that is all!
