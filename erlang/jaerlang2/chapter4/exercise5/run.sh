#!/bin/bash
SRC=math_functions
erlc $SRC.erl && erl -noshell -s $SRC test -s init stop
