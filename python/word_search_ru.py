#!/usr/bin/env python3

from random import randint

ширина = высота = 10

таблица = [
  [""] * ширина
  for _ in range(высота)
]

слова = input("введи слова через пробел: ").upper().split()

for слово in слова:
  while True:
    план = []
    x = randint(0, ширина - 1)
    y = randint(0, высота - 1)

    dx = randint(0, 1)
    dy = 1 - dx
    # или вправо или вниз

    for буква in слово:
      if not (
        0 <= x < ширина and
        0 <= y < высота and
        таблица[y][x] in ("", буква)
      ):
        break

      план.append((x, y, буква))
      x, y = x + dx, y + dy

    if len(план) != len(слово):
      continue

    for x, y, буква in план:
      таблица[y][x] = буква

    break

print()
for ряд in таблица:
  for буква in ряд:
    print(
      буква or chr(
        randint(ord("А"), ord("Я"))
      ),
      end="",
    )
  print()

"""
привет енот попробуй найти все эти слова и понять как это работает

ПРИВЕТУУПП
ТАЧЭЮПКЩЫО
ЮБИТЮЕВСЕП
ЭОШИДНСЬЕР
ГТСЕУОЛЭЩО
ЕАЭТЭТОКРБ
ТЕЦЮТТВАДУ
СТЮЮОЩАКЦЙ
НАЙТИЗЮЗМУ
ТПОНЯТЬЕЦЛ
"""
