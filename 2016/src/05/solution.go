package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

func part1(input string) string {
	counter := 0
	password := ""
	for len(password) < 8 {
		data := input + strconv.Itoa(counter)
		hashString := utils.Hash(data)
		if hashString[:5] == "00000" {
			password += string(hashString[5])
		}
		counter++
	}
	return password
}

func part2(input string) string {
	counter := 0
	password := strings.Split("________", "")
	// Joining here is a waste, but result is produced almost immediately, so it does not matter
	for strings.Count(strings.Join(password, ""), "_") != 0 {
		data := input + strconv.Itoa(counter)
		hashString := utils.Hash(data)
		if hashString[:5] == "00000" {
			if position, err := strconv.Atoi(string(hashString[5])); err == nil {
				if position >= 0 && position <= 7 && password[position] == "_" {
					password[position] = string(hashString[6])
				}
			}
		}
		counter++
	}
	return strings.Join(password, "")
}

func main() {
	input := "ffykfhsq"
	fmt.Printf("Part 1: %s\n", part1(input))
	fmt.Printf("Part 2: %s\n", part2(input))
}
