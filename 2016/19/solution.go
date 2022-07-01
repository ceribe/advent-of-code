package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
)

func part1(input int) string {
	i := 1
	for i*2 < input {
		i *= 2
	}
	l := input - i
	return strconv.Itoa(2*l + 1)
}

func part2(input int) string {
	i := 1
	for i*3 < input {
		i *= 3
	}
	return strconv.Itoa(input - i)
}

func main() {
	testInput := 5
	input := 3004953

	utils.Check("3", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))

	utils.Check("2", part2(testInput))
	fmt.Printf("Part 2: %s\n", part2(input))
}
