package main

import (
	utils "2016/src"
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

func isPasswordGuessed(password []string) bool {
	for _, char := range password {
		if char == "_" {
			return false
		}
	}
	return true
}

func part2(input string) string {
	counter := 0
	password := strings.Split("________", "")
	for !isPasswordGuessed(password) {
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
	fmt.Printf("Part 1: %s\n", part1(input)) // c6697b55
	fmt.Printf("Part 2: %s\n", part2(input)) // 8c35d1ab
}
