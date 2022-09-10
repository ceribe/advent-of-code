package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

type Instruction struct {
	code   string
	param1 string
	param2 string
}

func (instruction *Instruction) do(a *int, b *int, c *int, d *int, pos *int) int {
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
			return 2
		}
	case "out":
		*pos++
		return *b
	}
	*pos++
	return 2
}

func parseInput(input []string) []Instruction {
	instructions := make([]Instruction, 0)
	for _, line := range input {
		//Empty element is added, so I don't have to check range for inc/dec
		split := append(strings.Split(line, " "), "")
		instruction := Instruction{code: split[0], param1: split[1], param2: split[2]}
		instructions = append(instructions, instruction)
	}
	return instructions
}

func part1(input []string) string {
	currInt := 1
LOOP:
	for true {
		instructions := parseInput(input)
		a, b, c, d, pointer := currInt, 0, 0, 0, 0
		instructionsCount := len(instructions)
		previousBit := 1
		counter := 0
		for pointer < instructionsCount && counter < 1000 {
			ret := instructions[pointer].do(&a, &b, &c, &d, &pointer)
			if ret == 1 || ret == 0 {
				counter++
				if ret == previousBit {
					currInt++
					continue LOOP
				}
				previousBit = ret
			}
		}
		break
	}
	return strconv.Itoa(currInt)
}

func main() {
	input := utils.ReadInput("25", "input.txt")
	fmt.Printf("Part 1: %s\n", part1(input))
}
