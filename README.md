# :christmas_tree: :santa: :christmas_tree: Advent of Code :christmas_tree: :santa: :christmas_tree:

[Advent of Code](https://adventofcode.com/) is an annual event in December since 2015.
Every year since then, with the first day of December, a programming puzzles contest is published every day for twenty-four days.
A set of Christmas-oriented challenges provide any input you have to use to answer using the language of your choice.

# Description

This repository will contain my solutions for all years. Currently I'm in the process of merging separate repos into this one.

| Year | Status    | Language                                                                                        | Difficulty |
| ---- | --------- | ----------------------------------------------------------------------------------------------- | ---------- |
| 2015 | 50 :star: | <img alt="JavaScript" src="https://img.shields.io/badge/JavaScript-444444.svg?logo=javascript"> | 0          |
| 2016 | 50 :star: | <img alt="Go" src="https://img.shields.io/badge/Go-444444.svg?logo=go">                         | 6          |
| 2017 | 50 :star: | <img alt="Ruby" src="https://img.shields.io/badge/Ruby-444444.svg?logo=ruby&logoColor=CC342D">  | 4          |
| 2018 | DOING     | <img alt="Dart" src="https://img.shields.io/badge/Dart-444444.svg?logo=dart&logoColor=0175C2">  | 9          |
| 2019 | 0/25      |                                                                                                 |            |
| 2020 | DOING     | <img alt="Swift" src="https://img.shields.io/badge/Swift-444444.svg?logo=swift">                |            |
| 2021 | 50 :star: | <img alt="Kotlin" src="https://img.shields.io/badge/Kotlin-444444.svg?logo=Kotlin">             | 10         |

Difficulty is ranked from 0 to 10 where 0 is the easiest year and 10 is the hardest one.

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
