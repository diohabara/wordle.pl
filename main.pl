:- use_module(wordle).

main :-
  wordle:word_list('words.json', Words),
  wordle:pick_random_word(Words, TargetWord),
  wordle:format_string(TargetWord, TargetString), format('Target word: ~s~n', [TargetString]),
  wordle:guess_word(['_', '_', '_', '_', '_'], TargetWord, MatchedLetters),
  wordle:format_string(MatchedLetters, GuessedString), format('Guess: ~s~n', [GuessedString]),
  wordle:format_string(MatchedLetters, MatchedLettersString), format('Answer matches: ~w~n', [MatchedLettersString]).

:- initialization(main, main).
