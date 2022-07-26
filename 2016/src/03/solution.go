package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

func part1(input []string) string {
	count := 0
	for _, line := range input {
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

func part2(input []string) string {
	count := 0
	for i := 0; i < len(input); i += 3 {
		firstRow := strings.Fields(input[i])
		secondRow := strings.Fields(input[i+1])
		thirdRow := strings.Fields(input[i+2])
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
	fmt.Printf("Part 1: %s\n", part1(input)) // 983
	fmt.Printf("Part 2: %s\n", part2(input)) // 1836
}
