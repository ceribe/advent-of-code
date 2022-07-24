package main

import (
	utils "2016/src"
	"fmt"
	"log"
	"strconv"
	"strings"
)

type Direction int

const (
	North Direction = 0
	East  Direction = 1
	South Direction = 2
	West  Direction = 3
)

func getNextDir(currentDir Direction, turn string) Direction {
	if turn == "R" {
		return (currentDir + 1) % 4
	}
	return (currentDir - 1 + 4) % 4
}

func getNextPos(currentDir Direction, x int, y int, value int) (int, int) {
	switch currentDir {
	case North:
		return x, y + value
	case East:
		return x + value, y
	case South:
		return x, y - value
	case West:
		return x - value, y
	}
	log.Fatal("Invalid direction")
	return 0, 0
}

func part1(input string) string {
	instructions := strings.Split(input, ", ")
	x, y := 0, 0
	currentDir := North
	for _, instruction := range instructions {
		currentDir = getNextDir(currentDir, string(instruction[0]))
		value, _ := strconv.Atoi(instruction[1:])
		x, y = getNextPos(currentDir, x, y, value)
	}
	return strconv.Itoa(utils.Abs(x) + utils.Abs(y))
}

func part2(input string) string {
	instructions := strings.Split(input, ", ")
	x, y := 0, 0
	currentDir := North
	locations := make(map[int]int)
	for _, instruction := range instructions {
		currentDir = getNextDir(currentDir, string(instruction[0]))
		value, _ := strconv.Atoi(instruction[1:])
		nextX, nextY := getNextPos(currentDir, x, y, value)

		if nextX != x {
			for i := x; i < nextX; i++ {
				if _, ok := locations[i*10000+y]; ok {
					return strconv.Itoa(utils.Abs(i) + utils.Abs(y))
				}
				locations[i*10000+y] = 0
			}
		}
		if nextY != y {
			for i := y; i < nextY; i++ {
				if _, ok := locations[x*10000+i]; ok {
					return strconv.Itoa(utils.Abs(x) + utils.Abs(i))
				}
				locations[x*10000+i] = 0
			}
		}

		x, y = nextX, nextY
	}
	log.Fatal("Not found")
	return ""
}

func main() {
	testInput1 := "R2, L3"
	testInput2 := "R2, R2, R2"
	testInput3 := "R5, L5, R5, R3"
	testInput4 := "R8, R4, R4, R8"
	input := utils.ReadFirstLine("01", "input.txt")

	utils.Check("5", part1(testInput1))
	utils.Check("2", part1(testInput2))
	utils.Check("12", part1(testInput3))
	fmt.Println("Part 1:", part1(input)) // 271

	utils.Check("4", part2(testInput4))
	fmt.Println("Part 2:", part2(input)) // 153
}
