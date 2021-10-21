import json
from copy import copy
from random import choice
from typing import List

with open('words.json', 'r') as reader:
    words = json.loads(reader.read())["small_dict"]

big_words = []
for word in words:
    if len(word) == 8:
        big_words.append(word)

selected_word = choice(big_words)
print(selected_word)


def find_words(word_list: List[str], original_word: str) -> List[str]:
    valid_words = []
    if original_word in word_list:
        word_list.remove(original_word)

    for word in word_list:
        _word = copy(word)
        for letter in original_word:
            _word = _word.replace(letter, "", 1)

        if len(_word) == 0:
            valid_words.append(word)

    return valid_words


print(find_words(words, selected_word))
