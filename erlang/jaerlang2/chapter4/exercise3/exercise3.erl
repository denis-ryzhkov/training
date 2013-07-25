#!/usr/bin/env escript

% Solution to jaerlang2/chapter4/exercise3.
%
% https://github.com/denis-ryzhkov/training/blob/master/erlang/jaerlang2/chapter4/exercise3
% Copyright (C) 2013 by Denis Ryzhkov <denisr@denisr.com>
% MIT License, see http://opensource.org/licenses/MIT

% Look up the definitions of erlang:now/0, erlang:date/0, and erlang:time/0. Write a function called my_time_func(F), which evaluates the fun F and times how long it takes.
% Write a function called my_date_string() that neatly formats the current date and time of day

-module(exercise3).

-export([
    my_time_func/1,
    my_date_string/0,
    main/1
]).

my_time_func(F) ->

    % NOTE: erlang:trace_info()'s call_time may or may not be more precise. But trace_info() definetly is much more complex to use than now().
    % Best fit is probably timer:tc() that calls os:timestamp() with no overhead of sequential increment in now().
    % Anyway this exercise part is about now().

    {MegaSecs1, Secs1, MicroSecs1} = now(),
    Result = F(),
    {MegaSecs2, Secs2, MicroSecs2} = now(),

    io:format("~.3.0f seconds.~n", [(MegaSecs2 - MegaSecs1) * 1000000 + (Secs2 - Secs1) + (MicroSecs2 - MicroSecs1) / 1000]),
        % (MicroSecs2 - MicroSecs1) may be negative, so cannot just io:format("~w.~3..0w", [Secs, MicroSecs]).

    Result.

my_date_string() ->

    % NOTE: universaltime() and localtime() returns consistent DateTime value so fits better, but this exercise part is about date() and time().

    {Y, Mth, D} = date(),
    {H, Min, S} = time(),
    io:format("~w-~2..0w-~2..0w--~2..0w-~2..0w-~2..0w~n", [Y, Mth, D, H, Min, S]). % Almost ISO, but with filename-safe hyphens I prefer.

main(_) ->

    my_date_string(),

    % Seconds on my local netbook: escript vs erlc+erl:
    my_time_func(fun () -> true end),  % 0.042 vs 0.005 - warming up
    my_time_func(fun () -> true end),  % 0.024 vs 0.004
    my_time_func(fun () -> now() end), % 0.025 vs 0.006
    my_time_func(fun () -> now() end), % 0.025 vs 0.006 - stable

    {T, _} = timer:tc(fun () -> true end), % Just to compare now()'s overhead vs timer:tc() with its os:timestamp().
    io:format("~.3.0f seconds.~n", [T / 1000]), % 0.012 vs 0.004

    my_time_func(fun () -> timer:sleep(1000) end), % 1.688 vs 1.448 - both to more than 2.000.

    true.

% Takeaways:
% * Compiled Erlang may run about 5x faster than interpreted.
% * timer:sleep() can sleep very inaccurately - 2 seconds instead of 1.
% * timer:tc() and erlang:trace_info() should better be used IRL instead of now() - now().
