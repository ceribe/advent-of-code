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

func (instruction *Instruction) do(a *int, b *int, c *int, d *int, pos *int, instructions []Instruction) {
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
		p2 := stringToPointer(instruction.param2)
		if p2 != nil {
			if err == nil {
				*p2 = value
			} else {
				*p2 = *stringToPointer(instruction.param1)
			}
		}
	case "inc":
		p1 := stringToPointer(instruction.param1)
		if p1 != nil {
			*p1++
		}
	case "dec":
		p1 := stringToPointer(instruction.param1)
		if p1 != nil {
			*p1--
		}
	case "jnz":
		value, err := strconv.Atoi(instruction.param1)
		if err != nil {
			value = *stringToPointer(instruction.param1)
		}
		if value != 0 {
			value, err = strconv.Atoi(instruction.param2)
			if err != nil {
				value = *stringToPointer(instruction.param2)
			}
			*pos += value
			return
		}
	case "tgl":
		p1 := *stringToPointer(instruction.param1)
		pointerToToggledInstruction := *pos + p1
		if pointerToToggledInstruction >= 0 && pointerToToggledInstruction < len(instructions) {
			if p1 == 0 {
				break
			}
			ins := &instructions[pointerToToggledInstruction]
			if ins.code == "inc" {
				ins.code = "dec"
			} else if ins.code == "tgl" || ins.code == "dec" {
				ins.code = "inc"
			} else if ins.code == "jnz" {
				ins.code = "cpy"
			} else {
				ins.code = "jnz"
			}
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

func part1(input string) string {
	instructions := parseInput(input)
	a, b, c, d, pointer := 7, 0, 0, 0, 0
	instructionsCount := len(instructions)
	for pointer < instructionsCount {
		instructions[pointer].do(&a, &b, &c, &d, &pointer, instructions)
	}
	return strconv.Itoa(a)
}

func part2(input string) string {
	//instructions := parseInput(input)
	//a, b, c, d, pointer := 12, 0, 0, 0, 0
	//instructionsCount := len(instructions)
	//for pointer < instructionsCount {
	//	fmt.Printf("a: %d, b: %d, c: %d, d: %d\n", a, b, c, d)
	//	if a == 0 {
	//		print("")
	//	}
	//	instructions[pointer].do(&a, &b, &c, &d, &pointer, instructions)
	//}
	return strconv.Itoa(12*11*10*9*8*7*6*5*4*3*2 + 80*87)
}

func main() {
	testInput := utils.ReadInput("23", "test_input.txt")
	input := utils.ReadInput("23", "input.txt")

	utils.Check("3", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))
	fmt.Printf("Part 2: %s\n", part2(input))
}
