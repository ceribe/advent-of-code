package main

import (
	utils "advent-of-code-2016"
	"fmt"
)

func part1(input string) string {
	return ""
}

func part2(input string) string {
	return ""
}

func main() {
	testInput := utils.ReadInput("00", "test_input.txt")
	input := utils.ReadInput("00", "input.txt")

	utils.Check("0", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))

	utils.Check("0", part2(testInput))
	fmt.Printf("Part 2: %s\n", part2(input))
}
