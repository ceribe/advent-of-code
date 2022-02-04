package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"math"
)

func part1(input string) (code string) {
	lines := utils.SplitIntoLines(input)
	lettersCount := len(lines[0])
	for i := 0; i < lettersCount; i++ {
		letterMap := make(map[string]int)
		for _, line := range lines {
			letterMap[string(line[i])]++
		}
		maxCount, maxCountKey := 0, ""
		for key, val := range letterMap {
			if val > maxCount {
				maxCount = val
				maxCountKey = key
			}
		}
		code += maxCountKey
	}
	return
}

func part2(input string) (code string) {
	lines := utils.SplitIntoLines(input)
	lettersCount := len(lines[0])
	for i := 0; i < lettersCount; i++ {
		letterMap := make(map[string]int)
		for _, line := range lines {
			letterMap[string(line[i])]++
		}
		minCount, minCountKey := math.MaxInt, ""
		for key, val := range letterMap {
			if val < minCount {
				minCount = val
				minCountKey = key
			}
		}
		code += minCountKey
	}
	return
}

func main() {
	testInput := utils.ReadInput("06", "test_input.txt")
	input := utils.ReadInput("06", "input.txt")

	utils.Check("easter", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))

	utils.Check("advent", part2(testInput))
	fmt.Printf("Part 2: %s\n", part2(input))
}
