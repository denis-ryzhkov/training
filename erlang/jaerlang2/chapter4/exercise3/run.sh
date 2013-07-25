#!/bin/bash
# NOTE: Comment out with "%" first #!-line in SRC to compile with erlc.
SRC=exercise3
erlc $SRC.erl && erl -noshell -s $SRC main test -s init stop
