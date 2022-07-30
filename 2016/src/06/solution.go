package main

import (
	utils "2016/src"
	"fmt"
	"math"
)

// Creates a map which for each letter contains the number of times it appeared.
// Only letters on position i from each line are used.
func getLetterMap(i int, lines []string) map[string]int {
	letterMap := make(map[string]int)
	for _, line := range lines {
		letterMap[string(line[i])]++
	}
	return letterMap
}

func part1(input []string) (code string) {
	lettersCount := len(input[0])
	for i := 0; i < lettersCount; i++ {
		letterMap := getLetterMap(i, input)
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

func part2(input []string) (code string) {
	lettersCount := len(input[0])
	for i := 0; i < lettersCount; i++ {
		letterMap := getLetterMap(i, input)
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
	testInput := utils.ReadInput("06", "input_test.txt")
	input := utils.ReadInput("06", "input.txt")

	utils.Check("easter", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input)) // tzstqsua

	utils.Check("advent", part2(testInput))
	fmt.Printf("Part 2: %s\n", part2(input)) // myregdnr
}
