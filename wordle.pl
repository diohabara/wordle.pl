:- module(wordle, [word_list/2, read_jsonfile/2, pick_random_word/2, generate_random_word/2, compare_words/3, guess_word/3]).

:- use_module(library(http/json)).
:- use_module(library(random)).

alphabet(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']).

read_jsonfile(FilePath, Words) :-
  open(FilePath, read, Stream),
  json_read(Stream, Json),
  close(Stream),
  process_json(Json, Words).

process_json(Json, Words) :-
  is_list(Json),
  maplist(atom_chars, Json, Words).

word_list(FilePath, Words) :-
  read_jsonfile(FilePath, Words).

pick_random_word(Words, Word) :-
  random_member(Word, Words).

% generate_random_word(Guess, GeneratedWord)
generate_random_word([], []).
generate_random_word(['_' | GuessRest], [Char | GeneratedRest]) :-
  alphabet(Alphabet),
  random_member(Char, Alphabet),
  generate_random_word(GuessRest, GeneratedRest).
generate_random_word([Char | GuessRest], [Char | GeneratedRest]) :-
  generate_random_word(GuessRest, GeneratedRest).

% compare_words(Word1, Word2, MatchedLetters)
compare_words([], [], []).
compare_words([Char1 | Rest1], [Char2 | Rest2], [Char1 | MatchedRest]) :-
  Char1 = Char2,
  compare_words(Rest1, Rest2, MatchedRest).
compare_words([Char1 | Rest1], [Char2 | Rest2], ['_' | MatchedRest]) :-
  Char1 \= Char2,
  compare_words(Rest1, Rest2, MatchedRest).

% guess_word(CurrentGuess, TargetWord, MatchedLetters)
guess_word(CurrentGuess, TargetWord, NextGuess) :-
  generate_random_word(CurrentGuess, GeneratedWord),
  compare_words(GeneratedWord, TargetWord, NextGuess),
  GeneratedWord = NextGuess,
  NextGuess = TargetWord.
guess_word(CurrentGuess, TargetWord, MatchedLetters) :-
  generate_random_word(CurrentGuess, GeneratedWord),
  compare_words(GeneratedWord, TargetWord, NextGuess),
  NextGuess \= TargetWord,
  format_string(GeneratedWord, GeneratedWordString), format('Guess: ~s~n', [GeneratedWordString]),
  guess_word(NextGuess, TargetWord, MatchedLetters).

format_string(Chars, String) :-
  atom_chars(Atom, Chars),
  atom_string(Atom, String).
