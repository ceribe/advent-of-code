package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

func part1(input []string, password string) string {
	currPassword := strings.Split(password, "")
	for _, line := range input {
		op := strings.Split(line, " ")
		currPassword = applyOperation(currPassword, op)
	}
	return strings.Join(currPassword, "")
}

func applyOperation(password []string, op []string) []string {
	switch op[0] {
	case "swap":
		switch op[1] {
		case "position":
			x, _ := strconv.Atoi(op[2])
			y, _ := strconv.Atoi(op[5])
			return swapPosition(password, x, y)
		case "letter":
			return swapLetter(password, op[2], op[5])
		}
	case "rotate":
		x, _ := strconv.Atoi(op[2])
		switch op[1] {
		case "left":
			return rotateLeft(password, x)
		case "right":
			return rotateRight(password, x)
		case "based":
			idx := strings.Index(strings.Join(password, ""), op[6])
			if idx >= 4 {
				idx++
			}
			return rotateRight(password, idx+1)
		}
	case "reverse":
		x, _ := strconv.Atoi(op[2])
		y, _ := strconv.Atoi(op[4])
		return reverseThrough(password, x, y)
	case "move":
		x, _ := strconv.Atoi(op[2])
		y, _ := strconv.Atoi(op[5])
		return move(password, x, y)
	}
	return nil
}

func swapPosition(password []string, x int, y int) []string {
	tmp := password[x]
	password[x] = password[y]
	password[y] = tmp
	return password
}

func swapLetter(password []string, s string, s2 string) []string {
	str := strings.Join(password, "")
	str = strings.ReplaceAll(str, s, ".")
	str = strings.ReplaceAll(str, s2, s)
	str = strings.ReplaceAll(str, ".", s2)
	return strings.Split(str, "")
}

func rotateLeft(password []string, x int) []string {
	for i := 0; i < x; i++ {
		password = append(password[1:], password[0])
	}
	return password
}

func rotateRight(password []string, x int) []string {
	for i := 0; i < x; i++ {
		password = append(password[len(password)-1:], password[:len(password)-1]...)
	}
	return password
}

func reverseThrough(password []string, x int, y int) []string {
	left := password[:x]
	right := password[y+1:]
	mid := password[x : y+1]
	for i, j := 0, len(mid)-1; i < j; i, j = i+1, j-1 {
		mid[i], mid[j] = mid[j], mid[i]
	}
	return append(append(left, mid...), right...)
}

func move(password []string, x int, y int) []string {
	letterAtX := password[x]
	password = append(password[:x], password[x+1:]...)
	password = append(password[:y+1], password[y:]...)
	password[y] = letterAtX
	return password
}

//No need to write an unscrambler. Input is so small that generating all possible passwords and
//scrambling them is enough to find the correct one.
func part2(input []string, password string) (res string) {
	var generatePermutation func(sampleRune []rune, left, right int)
	generatePermutation = func(sampleRune []rune, left, right int) {
		if left == right {
			scrambled := part1(input, string(sampleRune))
			if scrambled == password {
				res = string(sampleRune)
			}
		} else {
			for i := left; i <= right; i++ {
				sampleRune[left], sampleRune[i] = sampleRune[i], sampleRune[left]
				generatePermutation(sampleRune, left+1, right)
				sampleRune[left], sampleRune[i] = sampleRune[i], sampleRune[left]
			}
		}
	}
	passwordRune := []rune("abcdefgh")
	generatePermutation(passwordRune, 0, len(passwordRune)-1)
	return
}

func main() {
	testInput := utils.ReadInput("21", "input_test.txt")
	input := utils.ReadInput("21", "input.txt")

	utils.Check("decab", part1(testInput, "abcde"))
	fmt.Printf("Part 1: %s\n", part1(input, "abcdefgh")) // gfdhebac
	fmt.Printf("Part 2: %s\n", part2(input, "fbgdceah")) // dhaegfbc
}
