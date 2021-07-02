import re
import sys
import unittest

def get_words(text):
    x = re.compile(r'\b([a-z0-9]+(?:[A-Z][a-z]*|[0-9]+)+)\b')
    return x.findall(text)

def camel_to_snake(text, word):
    new_word = re.sub(r'([A-Z]|[0-9]+)', r'_\1', word)
    new_word = new_word.lower().strip("_")
    text = text.replace(word, new_word)
    return text

class TestCamelCase(unittest.TestCase):
    def test_get_words(self):
        test = (
                    "thisIsCamelCase " 
                    "thisIsAlsoCamelCase " 
                    "thisIACamelCase " 
                    "ANDTHISISNOT "
                    "andthisisnot "
                    "andThisisSomewhatCamel_Here " 
                    "THIS_IS_JUST_BAD "
                    "thisisNOtNOTCamel_ "
                    "testCamillaCasa " 
                    "\n "
                    "CamelCaseNot "
                    "newLineThough " 
                    "thisIs1CamelCase "
                    "1AndThisAsWell " 
                    "100AndThisAsWell " 
                    "AndNotThisAsWell1 " 
                    "andThis100As100Well " 
                    "andThisAsWell1 " 
                    "andThisAsWell100 " 
                    "100 " 
        )

        expected = (
                    "thisIsCamelCase",
                    "thisIsAlsoCamelCase",
                    "thisIACamelCase",
                    "testCamillaCasa",
                    "newLineThough",
                    "1AndThisAsWell",
                    "100AndThisAsWell",
                    "andThis100As100Well",
                    "andThisAsWell1",
                    "andThisAsWell100",
                    "thisIs1CamelCase",
                    "100",
        )
        results = get_words(test)
        self.assertSetEqual(set(results), set(expected))


if __name__ == "__main__":
    for line in sys.stdin:
        for word in get_words(line):
            line = camel_to_snake(line, word)
        print(line, end="")
