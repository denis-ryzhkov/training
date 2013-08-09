#!/usr/bin/env escript

% Solution to jaerlang2/chapter4/exercise2:
%
%   Chapter4 exercises intro:
%   Find the manual page for the erlang module. You’ll see it lists a large number of BIFs (far more than we’ve covered here).
%   You’ll need this information to solve some of the following problems.
%
%   Exercise2:
%   The BIF tuple_to_list(T) converts the elements of the tuple T to a list.
%   Write a function called my_tuple_to_list(T) that does the same thing only not using the BIF that does this.
%
% https://github.com/denis-ryzhkov/training/blob/master/erlang/jaerlang2/chapter4/exercise2/exercise2.erl
% Copyright (C) 2013 by Denis Ryzhkov <denisr@denisr.com>
% MIT License, see http://opensource.org/licenses/MIT

-module(exercise2).

-export([
    my_tuple_to_list/1,
    main/1
]).

%%%% my_tuple_to_list

my_tuple_to_list(T) -> my_tuple_to_list(T, 1, tuple_size(T), []).
my_tuple_to_list(_, I, N, L) when I > N -> lists:reverse(L);
my_tuple_to_list(T, I, N, L) -> my_tuple_to_list(T, I + 1, N, [element(I, T) | L]).

%%%% test

assert(X, X) -> true.

main(_) ->

    assert(my_tuple_to_list({}), []),

    assert(my_tuple_to_list({aaa}), [aaa]),

    assert(my_tuple_to_list({2, bb}), [2, bb]),

    assert(my_tuple_to_list({3, {c, d}, [e]}), [3, {c, d}, [e]]),

    {'EXIT', {badarg, _}} = (catch my_tuple_to_list(<<"not tuple but even has size()">>)),

    io:format('OK~n').
