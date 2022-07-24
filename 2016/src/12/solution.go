package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

type Instruction struct {
	code   string
	param1 string
	param2 string
}

func (instruction *Instruction) do(a *int, b *int, c *int, d *int, pos *int) {
	stringToPointer := func(param string) *int {
		switch param {
		case "a":
			return a
		case "b":
			return b
		case "c":
			return c
		case "d":
			return d
		}
		return nil
	}
	switch instruction.code {
	case "cpy":
		value, err := strconv.Atoi(instruction.param1)
		if err == nil {
			*stringToPointer(instruction.param2) = value
		} else {
			*stringToPointer(instruction.param2) = *stringToPointer(instruction.param1)
		}
	case "inc":
		*stringToPointer(instruction.param1)++
	case "dec":
		*stringToPointer(instruction.param1)--
	case "jnz":
		value, err := strconv.Atoi(instruction.param1)
		if err != nil {
			value = *stringToPointer(instruction.param1)
		}
		if value != 0 {
			value, _ = strconv.Atoi(instruction.param2)
			*pos += value
			return
		}
	}
	*pos++
}

func parseInput(input string) []Instruction {
	instructions := make([]Instruction, 0)
	lines := utils.SplitIntoLines(input)
	for _, line := range lines {
		//Empty element is added, so I don't have to check range for inc/dec
		split := append(strings.Split(line, " "), "")
		instruction := Instruction{code: split[0], param1: split[1], param2: split[2]}
		instructions = append(instructions, instruction)
	}
	return instructions
}

func part1and2(input string, initialC int) string {
	instructions := parseInput(input)
	a, b, c, d, pointer := 0, 0, initialC, 0, 0
	instructionsCount := len(instructions)
	for pointer < instructionsCount {
		instructions[pointer].do(&a, &b, &c, &d, &pointer)
	}
	return strconv.Itoa(a)
}

func main() {
	testInput := utils.ReadInput("12", "test_input.txt")
	input := utils.ReadInput("12", "input.txt")

	utils.Check("42", part1and2(testInput, 0))
	fmt.Printf("Part 1: %s\n", part1and2(input, 0))

	utils.Check("42", part1and2(testInput, 1))
	fmt.Printf("Part 2: %s\n", part1and2(input, 1))
}
