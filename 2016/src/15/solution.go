package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

type Disc struct {
	positionsCount  int
	initialPosition int
}

func parseInput(input []string) []Disc {
	discs := make([]Disc, 0)
	for _, line := range input {
		split := strings.Split(strings.ReplaceAll(line, ".", ""), " ")
		initialPosition, _ := strconv.Atoi(split[11])
		positionsCount, _ := strconv.Atoi(split[3])
		disc := Disc{initialPosition: initialPosition, positionsCount: positionsCount}
		discs = append(discs, disc)
	}
	return discs
}

func (disc *Disc) isOnZero(time int) bool {
	return (disc.initialPosition+time)%disc.positionsCount == 0
}

func part1and2(input []string, addBonusDisc bool) string {
	discs := parseInput(input)
	if addBonusDisc {
		discs = append(discs, Disc{initialPosition: 0, positionsCount: 11})
	}
	time := 0
	for true {
		areAllOnZero := true
		for i := 0; i < len(discs); i++ {
			if !discs[i].isOnZero(time + i + 1) {
				areAllOnZero = false
				break
			}
		}
		if areAllOnZero {
			return strconv.Itoa(time)
		}
		time++
	}
	return ""
}

func main() {
	testInput := utils.ReadInput("15", "input_test.txt")
	input := utils.ReadInput("15", "input.txt")

	utils.Check("5", part1and2(testInput, false))
	fmt.Printf("Part 1: %s\n", part1and2(input, false)) // 148737

	utils.Check("85", part1and2(testInput, true))
	fmt.Printf("Part 2: %s\n", part1and2(input, true)) // 2353212
}
