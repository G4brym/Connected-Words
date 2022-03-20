# Connected Words

Connected word is a very simple mobile game, where the player needs to find all words that can be built using a
given list of letters, inspired by [this game](https://play.google.com/store/apps/details?id=com.wordgame.words.connect).

This game is built using the [Godot Engine](https://godotengine.org/) and has an integration with 
[Catappult Eskills](https://docs.catappult.io/) that provided an easy multiplayer system with matchmaking
and money prizes for players.

The Eskills integration was built using [godot-eskills](https://github.com/G4brym/godot-eskills), that is
a very small godot plugins that makes it very easy to add this functionality to games.


## Features
- Very simple UI
- Word picker, by swiping on the letters
- Word preview
- Letter shuffle
- Score system
- Easy to add new words to the game
- Easy to make available with other languages
- Multiplayer mode
- Random words everytime you play
- Multiple levels, after completing 80% of the words on the board


## How the game knows what are valid words
In the Dictionaries folder, are 2 word lists, the "small" (aka game words) contains the 1 000 most used 
words in the english dictionary, the other one contains about 10 000 common used words (aka optional words).

The game words are the only words that can show up in the game board, the optional words are used as a 
small reward for the player to find a word outside the most used words.


## Point system
The player is rewarded for each word he finds. 

If the word found belongs to the game words, the player receives the same amount of points as the number 
of letters in the word.

If the player finds an optional word, he receives just 1 point as extra bonus.


## How the game pick's the Board Words
In the beginning of each game or new level, the game picks a random game word with a length of 6 or 7
letters, then it gets all anagrams that are in the game words list and places it in the game board.

During the game start, all anagram words that are in the optional words are also saved in memory to be match
every time the player tries a new word that is not in the game board.


## Images of the game
Home

![Home](https://github.com/G4brym/Connected-Words/raw/master/images/home.png)

Singleplayer game

![Singleplayer game](https://github.com/G4brym/Connected-Words/raw/master/images/singleplayer-game.png)

Multiplayer start

![Multiplayer start](https://github.com/G4brym/Connected-Words/raw/master/images/multiplayer-entry.png)

Multiplayer name picker

![Multiplayer name picker](https://github.com/G4brym/Connected-Words/raw/master/images/multiplayer-name-pick.png)

Multiplayer game

![Multiplayer game](https://github.com/G4brym/Connected-Words/raw/master/images/multiplayer-game.png)

Multiplayer Finish

![Multiplayer Finish](https://github.com/G4brym/Connected-Words/raw/master/images/multiplayer-finish.png)
