# [Advent of Code 2020](https://adventofcode.com/2020)

Swift enforces a project structure so it is a bit different than in other years.
"src" directory is replaced with "Sources". Then instead of the usual "solution.sth" file
there is a "main.swift" file. Additionaly utils file is in an additional package.

## The Hardest One

TODO

## The Most Tedious One

TODO

## The Most Fun One

TODO

# How to run

## Preconditions

Steps below assume you are using a Linux distribution which has access to AUR. If you are
using a different distro then you are on your own.

- Install Swift

```bash
yay -S swift-bin
```

- Install VSCode

```bash
yay -S visual-studio-code-bin
```

- Install [Swift Extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) for VSCode

## Run

After cloning open "2020" directory in VSCode. Switch to the "Run and Debug" tab and run
one of the configurations. For each day there is a release/debug configuration.

# My thoughts about Swift

Overall this language seems nice. Syntax is pleasant and it has a lot of modern features.
Looks quite similiar to Kotlin, especially when it comes to passing lambdas as arguments.
Now for the bad parts. Tooling for Linux could be better. While plugin does quite a lot
it does not highlight errors on the fly, but only after compilation. Also reading a file
was surprisingly challenging, because I could not use any of the built-in functions, because
they work only on Apple platforms. Another thing that seemed surreal was the fact that you
cannot subscript Strings with Ints. I wrote an extension function to "fix" that, but even
after reading about why it is this way it seemed bizarre.
