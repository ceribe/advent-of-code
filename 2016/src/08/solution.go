package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

func applyInstruction(screen [][]uint8, instruction string) {
	split := strings.Split(instruction, " ")
	if split[0] == "rect" {
		size := strings.Split(split[1], "x")
		width, _ := strconv.Atoi(size[0])
		height, _ := strconv.Atoi(size[1])
		for i := 0; i < width; i++ {
			for j := 0; j < height; j++ {
				screen[i][j] = 1
			}
		}
	} else {
		idx, _ := strconv.Atoi(strings.Split(split[2], "=")[1])
		offset, _ := strconv.Atoi(split[4])
		if split[1] == "row" {
			rotateRow(idx, offset, screen)
		} else {
			rotateColumn(idx, offset, screen)
		}
	}
}

func rotateRow(idx int, offset int, screen [][]uint8) {
	newRow := make([]uint8, 50)
	for i := 0; i < 50; i++ {
		newRow[(i+offset)%50] = screen[i][idx]
	}
	for i := 0; i < 50; i++ {
		screen[i][idx] = newRow[i]
	}
}

func rotateColumn(idx int, offset int, screen [][]uint8) {
	newColumn := make([]uint8, 6)
	for i := 0; i < 6; i++ {
		newColumn[(i+offset)%6] = screen[idx][i]
	}
	for i := 0; i < 6; i++ {
		screen[idx][i] = newColumn[i]
	}
}

func part1and2(input []string) {
	screen := make([][]uint8, 50)
	for i := range screen {
		screen[i] = make([]uint8, 6)
	}

	for _, instruction := range input {
		applyInstruction(screen, instruction)
	}
	counter := 0
	for _, column := range screen {
		for _, pixel := range column {
			if pixel == 1 {
				counter++
			}
		}
	}
	fmt.Printf("Part 1: %s\n", strconv.Itoa(counter))
	fmt.Printf("Part 2:\n")
	for i := 0; i < 6; i++ {
		for j := 0; j < 50; j++ {
			letter := ""
			if screen[j][i] == 1 {
				letter = "#"
			} else {
				letter = " "
			}
			fmt.Print(letter)
		}
		fmt.Print("\n")
	}
}

func main() {
	input := utils.ReadInput("08", "input.txt")
	part1and2(input) // 106 and CFLELOYFCS
}
