# Wordle.pl

## What is Wordle?

Wordle is a word-guessing game where players try to guess a five-letter word within a limited number of attempts. In each attempt, the player provides a five-letter word, and the game provides feedback on the correctness of the guess. The feedback consists of indicating which letters are correct and in the correct position, and which letters are correct but in the wrong position. The objective is to deduce the correct word based on the feedback received.

## Project Description

This project implements a Wordle solver in Prolog. The solver generates a random five-letter word and compares it with a picked word. If the generated word matches the picked word, the solver outputs the result. Otherwise, the solver generates another random five-letter word and compares it with the picked word. The process continues until the generated word matches the picked word.

## Design and Implementation

The main predicate is in `main.pl`.

### 1. Pick a word from a word list randomly.

- The word list is a list of five-letter words.
- `words.json` contains a list of five-letter words.
  - The words are in the form of a JSON array.
- `read_jsonfile/2` reads the word list from `words.json`.
  - The first argument is the file name.
  - The second argument is the word list.
- `pick_random_word/2` picks a word from the word list.
  - The first argument is the word list.
  - The second argument is the picked up word.

### 2. Generate a five-letter word generated randomly. and compare the generated word with the picked up word.

- `guess_word/3` generates a five-letter word.
  - The first argument is the current matched letters.
  - The second argument is the picked up word.
  - The third argument is the guessed word.
  - `_` char will be replaced with a random letter.
  - e.g.,

```
guess_word(['_', '_', '_', '_', 'e'], ['z', 'o', 'r', 'i', 's'], ['z', 'o', 'r', 'i', 's']).
guess_word(['_', '_', '_', '_', '_'], ['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e']).
```

- `generate_random_word/2` generates a five-letter word randomly.
  - The first argument is the matched letters.
  - The second argument is the generated word.
  - `_` char will be replaced with a random letter.
  - e.g.,

```
generate_random_word(['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e']).
generate_random_word(['_', '_', '_', '_', 'e'], ['x', 'h', 'b', 'i', 'e']).
```

- `compare_words/3` compares two words.
  - The first argument is the picked up word.
  - The second argument is the generated word.
  - The third argument is the result of the comparison.
    - an alphabet means the letter is matched
    - `_` means the letter is not matched
    - e.g.,

```prolog
compare_words(['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e']).
compare_words(['a', 'p', 'p', 'l', 'e'], ['o', 'a', 'n', 'g', 'e'], ['_', '_', '_', '_', 'e']).
compare_words(['a', 'b', 'c', 'd', 'e'], ['a', 'p', 'p', 'l', 'e'], ['a', '_', '_', '_', 'e']).
```

### 3. If they are the same, output the result; otherwise, go back to 2.

## How to run

### Install dependencies

Install SWI-Prolog, or use nix to install dependencies in `shell.nix`.

### Unit tests

Run the unit tests for the Wordle solver in `wordle.plt`. Every predicate is in `wordle.pl`.

```bash
swipl -g run_tests -t halt ./wordle.plt
```

### Run solver

Run the solver and output the solving process.

```bash
swipl -q -s main.pl -t halt
```

Below is an example output of the solver.

```bash
$ swipl -q -s main.pl -t halt
Target word: piked
Guess: jdrky
Guess: ngvix
Guess: bawzh
Guess: preui
Guess: pafmh
Guess: poplr
Guess: pifhi
Guess: pikjy
Guess: pikbd
Guess: pikud
Guess: pikfd
Guess: pikyd
Guess: pikad
Guess: piked
Answer matches: piked
```

## Special Thanks

- `words.json` is from [this repository](https://github.com/chidiwilliams/wordle/blob/main/src/data/words.json).
