from random import choices
from functools import reduce
import os
from graphics import GRAPHICS

# Hangman coded as a challenge for the intermediate Python curse at PLatzi by @maurogome (04/24/2021)

def read_words():

    words = []
    with open("./archivos/words.txt", "r", encoding = "utf-8") as f:
        for line in f:
            words.append(line)

    return words

def print_board(hidden_word, lifes, tries):

    os.system("cls")
    print("-" * 55)
    print("-." * 10, "H A N G M A N", ".-" * 10 )
    print("-" * 55)

    if lifes > 0:
        print(" " * 20,"❤"*lifes)
        print(GRAPHICS[lifes])
        print(f"Adivina la palabra de {len(hidden_word)} letras:")
        print(" " * 20, end = "")

        for char in hidden_word:
            print(char.upper(), end = " ")

        print("\n\n","-" * 55)
        print("\n", "Letras que haz intentado:", end = "\n\n")
        print(" " * 10,">> ", end = "")

        for char in tries:
            print(char.upper(), end = " ")

        print("\n")
    else:
        print(GRAPHICS[lifes])

def check_letter(word, letter, hidden_word, lifes):

    life_lost = True
    word_list = [char for char in word]
    hidden_word_list = []

    for index, char in enumerate(word_list):

        if hidden_word[index] == "_":
            if char == letter:
                hidden_word_list.append(char)
                life_lost = False
            else:
                hidden_word_list.append("_")
        else:
            hidden_word_list.append(hidden_word[index])

    if life_lost:
        lifes -= 1

    return lifes, [word.join(char) for char in hidden_word_list]


def check_win(hidden_word):
    if "_" in hidden_word:
        return False
    else:
        return True

def clean_word(word):
    word_list = []
    vowels = {"á":"a", "é":"e", "'i":"i", "ó":"o", "ú":"u"}
    clean_word = ""

    for char in word:
        if vowels.get(char):
            word_list.append(vowels.get(char))
        else:
            word_list.append(char)

    return clean_word.join(word_list)

def ask_letter(tries):
    letter = input("Ingresa una letra: ")
    valid_letter = False

    while not valid_letter:
        if len(letter) != 1 or letter.isalpha() == False or letter in tries:
            letter = input("Ingresa solo una letra: ")
        else:
            valid_letter = True

    return letter

def run():
    data = read_words()
    word = (choices(data, k = 1))[0].strip("\n")
    word = clean_word(word)
    hidden_word = "_"*len(word)
    lifes = 7
    tries = []

    while lifes > 0:
        print_board(hidden_word, lifes, tries)
        letter = ask_letter(tries)
        tries.append(letter)
        lifes, hidden_word = check_letter(word, letter, hidden_word, lifes)

        if check_win(hidden_word):
            print_board(hidden_word, lifes, tries)
            print("Felicidades. Ganaste!")
            break

    if lifes == 0:
        print_board(hidden_word, lifes, tries)
        print("\nEstas Muerto!", end="\n\n")

    input("\nPresiona Enter para finalizar")
    os.system("cls")

if __name__ == "__main__":
    run()
