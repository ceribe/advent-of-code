package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

func part1(input string) string {
	lines := utils.SplitIntoLines(input)
	count := 0
	for _, line := range lines {
		numbers := strings.Fields(line)
		a, _ := strconv.Atoi(numbers[0])
		b, _ := strconv.Atoi(numbers[1])
		c, _ := strconv.Atoi(numbers[2])
		if a+b > c && a+c > b && b+c > a {
			count++
		}
	}
	return strconv.Itoa(count)
}

func part2(input string) string {
	lines := utils.SplitIntoLines(input)
	count := 0
	for i := 0; i < len(lines); i += 3 {
		firstRow := strings.Fields(lines[i])
		secondRow := strings.Fields(lines[i+1])
		thirdRow := strings.Fields(lines[i+2])
		for j := 0; j < 3; j++ {
			a, _ := strconv.Atoi(firstRow[j])
			b, _ := strconv.Atoi(secondRow[j])
			c, _ := strconv.Atoi(thirdRow[j])
			if a+b > c && a+c > b && b+c > a {
				count++
			}
		}

	}
	return strconv.Itoa(count)
}

func main() {
	input := utils.ReadInput("03", "input.txt")
	fmt.Printf("Part 1: %s\n", part1(input))
	fmt.Printf("Part 2: %s\n", part2(input))
}
