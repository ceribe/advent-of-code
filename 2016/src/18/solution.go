package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
)

func getFloorMatrix(input string, rows int) [][]bool {
	//2D matrix representing floor. Traps are marked as "true"
	floor := make([][]bool, rows)
	for y := range floor {
		floor[y] = make([]bool, len(input))
	}
	for idx, char := range input {
		if char == '^' {
			floor[0][idx] = true
		}
	}
	return floor
}

func generateRow(floor [][]bool, rowIdx int) {
	width := len(floor[rowIdx])
	for idx := range floor[rowIdx] {
		left := false
		if idx-1 >= 0 {
			left = floor[rowIdx-1][idx-1]
		}
		center := floor[rowIdx-1][idx]
		right := false
		if idx+1 < width {
			right = floor[rowIdx-1][idx+1]
		}
		if (left && center && !right) ||
			(!left && center && right) ||
			(left && !center && !right) ||
			(!left && !center && right) {
			floor[rowIdx][idx] = true
		}
	}
}

func part1and2(input string, rows int) string {
	floor := getFloorMatrix(input, rows)
	for i := 1; i < rows; i++ {
		generateRow(floor, i)
	}
	counter := 0
	for _, row := range floor {
		for _, isTrap := range row {
			if !isTrap {
				counter++
			}
		}
	}
	return strconv.Itoa(counter)
}

func main() {
	testInput1 := "..^^."
	testInput2 := ".^^.^.^^^^"
	input := ".^^^.^.^^^.^.......^^.^^^^.^^^^..^^^^^.^.^^^..^^.^.^^..^.^..^^...^.^^.^^^...^^.^.^^^..^^^^.....^...."

	utils.Check("6", part1and2(testInput1, 3))
	utils.Check("38", part1and2(testInput2, 10))
	fmt.Printf("Part 1: %s\n", part1and2(input, 40))     // 2013
	fmt.Printf("Part 2: %s\n", part1and2(input, 400000)) // 20006289
}
