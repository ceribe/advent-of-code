package main

import (
	utils "2016/src"
	"fmt"
	"regexp"
	"strconv"
)

func hasABBA(text string) bool {
	for i := 0; i < len(text)-3; i++ {
		if text[i] != text[i+1] && text[i] == text[i+3] && text[i+1] == text[i+2] {
			return true
		}
	}
	return false
}

func part1(input []string) string {
	count := 0
	for _, line := range input {
		parts := regexp.MustCompile(`]|\[`).Split(line, -1)
		supportsTLS := false
		for i, part := range parts {
			if !hasABBA(part) {
				continue
			}
			if i%2 == 0 {
				supportsTLS = true
			} else {
				supportsTLS = false
				break
			}
		}
		if supportsTLS {
			count++
		}
	}
	return strconv.Itoa(count)
}

func part2(input []string) string {
	count := 0
	for _, line := range input {
		parts := regexp.MustCompile(`]|\[`).Split(line, -1)

		//Collect all ABAs from IPv7 address
		ABASet := make(map[string]bool)
		for i := 0; i < len(parts); i += 2 {
			part := parts[i]
			for j := 0; j < len(part)-2; j++ {
				if part[j] == part[j+2] && part[j] != part[j+1] {
					ABA := string(part[j]) + string(part[j+1]) + string(part[j+2])
					ABASet[ABA] = true
				}
			}
		}

		//Find BABs and check if any matching ABA is in set
	LOOP:
		for i := 1; i < len(parts); i += 2 {
			part := parts[i]
			for j := 0; j < len(part)-2; j++ {
				if part[j] != part[j+2] || part[j] == part[j+1] {
					continue
				}
				ABA := string(part[j+1]) + string(part[j]) + string(part[j+1])
				if ABASet[ABA] {
					count++
					break LOOP
				}
			}
		}
	}
	return strconv.Itoa(count)
}

func main() {
	testInput := utils.ReadInput("07", "input_test.txt")
	testInput2 := utils.ReadInput("07", "input_test_2.txt")
	input := utils.ReadInput("07", "input.txt")

	utils.Check("2", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input)) // 118

	utils.Check("3", part2(testInput2))
	fmt.Printf("Part 2: %s\n", part2(input)) // 260
}
