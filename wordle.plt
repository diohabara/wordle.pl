:- use_module(wordle).
:- begin_tests(wordle).  % for plunit

compare_words([], []).
compare_words([H1|T1], [_|T2]) :-
  H1 \= '_',
  compare_words(T1, T2).
compare_words([H1|T1], [H2|T2]) :-
  H1 = H2,
  compare_words(T1, T2).

test('read_jsonfile/2', [nondet]) :-
  read_jsonfile('words.json', Words),
  length(Words, 12484).

test('word_list/2', [nondet]) :-
  word_list('words.json', Words),
  maplist(length, Words, Lengths),
  maplist(=(5), Lengths).

test('pick_random_word/3', [nondet]) :-
  read_jsonfile('words.json', Words),
  pick_random_word(Words, RandomWord),
  member(RandomWord, Words).

test('generate_random_word/2', [nondet]) :-
  generate_random_word(['_', '_', '_', '_', '_'], RandomWord1),
  length(RandomWord1, 5),
  generate_random_word(['_', '_', 'a', 'b', 'c'], RandomWord2),
  length(RandomWord2, 5),
  compare_words(['_', '_', 'a', 'b', 'c'], RandomWord2).

test('compare_words/3', [nondet]) :-
  compare_words(['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e']),
  compare_words(['a', 'p', 'p', 'l', 'e'], ['o', 'a', 'n', 'g', 'e'], ['_', '_', '_', '_', 'e']),
  compare_words(['a', 'b', 'c', 'd', 'e'], ['a', 'p', 'p', 'l', 'e'], ['a', '_', '_', '_', 'e']).

test('guess_word/3', [nondet]) :-
  guess_word(['_', '_', '_', '_', '_'], ['z', 'o', 'r', 'i', 's'], ['z', 'o', 'r', 'i', 's']),
  guess_word(['_', '_', '_', '_', '_'], ['a', 'p', 'p', 'l', 'e'], ['a', 'p', 'p', 'l', 'e']).

:- end_tests(wordle).
