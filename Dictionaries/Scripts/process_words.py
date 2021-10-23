import json
from typing import List, Set


def read_file(filename: str) -> Set[str]:
    with open(filename, 'r') as reader:
        raw_words = reader.read().split("\n")

    # Remove words bigger than 8 chars and less than 2
    cleaned_words = set()
    for word in raw_words:

        _word = str(word).strip()
        _size = len(_word)
        if _size >= 2 and _size <= 8:
            cleaned_words.add(_word)

    return cleaned_words


def write_output(small_dict: List[str], big_dict: List[str]) -> None:
    with open('words.json', 'w') as outfile:
        json.dump(dict(
            small_dict=small_dict,
            big_dict=big_dict,
        ), outfile, indent=4, sort_keys=True)


if __name__ == "__main__":
    small_dict = read_file("english_words_small.txt")
    big_dict = read_file("english_words.txt")

    # This just makes things easier latter in engine, we don't have to check in 2 places if it is the same word
    big_dict -= small_dict

    write_output(
        small_dict=sorted(small_dict),
        big_dict=sorted(big_dict),
    )
