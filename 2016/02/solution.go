package main

import (
	utils "2016"
	"fmt"
	"strconv"
)

func part1(input []string) string {
	x, y := 1, 1
	code := ""
	for _, line := range input {
		for _, instruction := range line {
			switch string(instruction) {
			case "U":
				y = utils.Max(0, y-1)
			case "D":
				y = utils.Min(2, y+1)
			case "R":
				x = utils.Min(2, x+1)
			case "L":
				x = utils.Max(0, x-1)
			}
		}
		code += strconv.Itoa(3*y + x + 1)
	}
	return code
}

func part2(input []string) string {
	x, y := 0, 2
	numpad := [5]string{"  1  ", " 234 ", "56789", " ABC ", "  D  "}
	code := ""
	for _, line := range input {
		for _, instruction := range line {
			switch string(instruction) {
			case "U":
				newY := y - 1
				if newY >= 0 && string(numpad[newY][x]) != " " {
					y = newY
				}
			case "D":
				newY := y + 1
				if newY <= 4 && string(numpad[newY][x]) != " " {
					y = newY
				}
			case "R":
				newX := x + 1
				if newX <= 4 && string(numpad[y][newX]) != " " {
					x = newX
				}
			case "L":
				newX := x - 1
				if newX >= 0 && string(numpad[y][newX]) != " " {
					x = newX
				}
			}
		}
		code += string(numpad[y][x])
	}
	return code
}

func main() {
	testInput := utils.ReadInput("02", "input_test.txt")
	input := utils.ReadInput("02", "input.txt")

	utils.Check("1985", part1(testInput))
	fmt.Println("Part 1:", part1(input)) // 14894

	utils.Check("5DB3", part2(testInput))
	fmt.Println("Part 2:", part2(input)) // 26B96
}
