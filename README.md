# Welcome to Advent of Code[^aoc]

This repository will contain my solutions for all years. Currently I'm in the process of merging separate repos into this one.

| YEAR | PROGRESS | LANGUAGE |
| ---- | -------- | -------- |
| 2015 | DONE     | <img alt="JavaScript" src="https://img.shields.io/badge/JavaScript-444444.svg?logo=javascript"> |
| 2016 | DONE     | <img alt="Go" src="https://img.shields.io/badge/Go-444444.svg?logo=go"> |
| 2017 | DONE     | <img alt="Ruby" src="https://img.shields.io/badge/Ruby-444444.svg?logo=ruby&logoColor=CC342D"> |
| 2018 | 20/25    | <img alt="Dart" src="https://img.shields.io/badge/Dart-444444.svg?logo=dart&logoColor=0175C2"> |
| 2019 | 0/25     | |
| 2020 | 0/25     | <img alt="Swift" src="https://img.shields.io/badge/Swift-444444.svg?logo=swift"> |
| 2021 | DONE     | <img alt="Kotlin" src="https://img.shields.io/badge/Kotlin-444444.svg?logo=Kotlin"> |

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
