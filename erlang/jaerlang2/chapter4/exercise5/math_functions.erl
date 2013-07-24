% My first Erlang code.
% Solution to jaerlang2/chapter4/exercise5.
%
% https://github.com/denis-ryzhkov/training/blob/master/erlang/jaerlang2/chapter4/exercise5/math_functions.erl
% Copyright (C) 2013 by Denis Ryzhkov <denisr@denisr.com>
% MIT License, see http://opensource.org/licenses/MIT

-module(math_functions).

-export([
    even/1,
    odd/1,
    test/0
]).

%%%% even

even(X) when X rem 2 =:= 0 -> true;
even(_) -> false.

%%%% odd

odd(X) -> not even(X).

%%%% test

assert(X, X) -> true.

test() ->
    L = lists:seq(-2, 2),
    assert([even(X) || X <- L], [true, false, true, false, true]),
    assert([odd(X) || X <- L], [false, true, false, true, false]),
    io:format("OK~n").
