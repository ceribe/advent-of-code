# :christmas_tree: :santa: :christmas_tree: Advent of Code :christmas_tree: :santa: :christmas_tree:

[Advent of Code](https://adventofcode.com/) is an annual event in December since 2015.
Every year since then, with the first day of December, a programming puzzles contest is published every day for twenty-four days.
A set of Christmas-oriented challenges provide any input you have to use to answer using the language of your choice.

# Description

This repository will contains my solutions for all years. Some of them are refactored, some are not. Some look nice, some are horrible to look at.

Solutions in this repo prioritize readability and minimize the amount of time it takes to write them. So for example if I can solve
a problem in 5min using bruteforce or some hack I will do it instead of spending 2h writing a proper solution. That is why some
solutions are less than optimal and when run may require more time. The only reason why I would do this is the fact that I only
need the program to run once. I'll most likely never run it again so execution speed does not matter. Despite that I like when my
code is clean and readable so I try to keep it as such.

Difficulty is ranked from 0 to 10 where 0 is the easiest year and 10 is the hardest one.

| Year | Status    | Language                                                                                        | Difficulty | Refactored? |
| ---- | --------- | ----------------------------------------------------------------------------------------------- | ---------- | -- |
| 2015 | 50 :star: | <img alt="JavaScript" src="https://img.shields.io/badge/JavaScript-444444.svg?logo=javascript"> | 0          | :heavy_check_mark: |
| 2016 | 50 :star: | <img alt="Go" src="https://img.shields.io/badge/Go-444444.svg?logo=go">                         | 6          | :heavy_check_mark: |
| 2017 | 50 :star: | <img alt="Ruby" src="https://img.shields.io/badge/Ruby-444444.svg?logo=ruby&logoColor=CC342D">  | 4          ||
| 2018 | 46 :star: | <img alt="Dart" src="https://img.shields.io/badge/Dart-444444.svg?logo=dart&logoColor=0175C2">  | 9          ||
| 2019 | 00 :star: |                                                                                                 |            ||
| 2020 | 06 :star: | <img alt="Swift" src="https://img.shields.io/badge/Swift-444444.svg?logo=swift">                | ?          ||
| 2021 | 50 :star: | <img alt="Kotlin" src="https://img.shields.io/badge/Kotlin-444444.svg?logo=Kotlin">             | 10         | :heavy_check_mark: |
| 2022 | 22 :star: | <img alt="Crystal" src="https://img.shields.io/badge/Crystal-444444.svg?logo=Crystal">          | ?          ||


# Code Organization

Each year has its own directory. In each year-directory there is a README, a year specific gitignore, files needed for project
(build.gradle.kts for Kotlin, package.json for JS, go.mod for Go and etc.) and "src" directory containing
all the solutions. In "src" each day has its own directory either named "XX" or "dXX" depending on language requirements.
Additionaly in "src" there is a "utils" file containing code shared between days (like reading input, checking results
and some more). In each day-directory there is a solution file containing the code for both parts, inputs for days where this applies
and README with a link to the respective challange.

[^aoc]:
    [Advent of Code][aoc] – an annual event in December since 2015.
    Every year since then, with the first day of December, a programming puzzles contest is published every day for twenty-four days.
    A set of Christmas-oriented challenges provide any input you have to use to answer using the language of your choice.

[aoc]: https://adventofcode.com
