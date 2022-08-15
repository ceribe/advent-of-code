package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
)

type State int

const (
	ConsumingChars       State = 0
	CollectingCount      State = 1
	CollectingRepetition State = 2
)

func calculateDecompressedLength(text string, version int) (size int) {
	state := ConsumingChars
	count := 0
	collectedCount := ""
	collectedRepetition := ""
	for i := 0; i < len(text); i++ {
		switch state {
		case ConsumingChars:
			if string(text[i]) != "(" {
				size++
			} else {
				state = CollectingCount
			}
		case CollectingCount:
			if string(text[i]) != "x" {
				collectedCount += string(text[i])
			} else {
				state = CollectingRepetition
				count, _ = strconv.Atoi(collectedCount)
				collectedCount = ""
			}
		case CollectingRepetition:
			if string(text[i]) != ")" {
				collectedRepetition += string(text[i])
			} else {
				state = ConsumingChars
				repetition, _ := strconv.Atoi(collectedRepetition)
				collectedRepetition = ""
				if version == 2 {
					size += calculateDecompressedLength(text[i+1:i+count+1], 2) * repetition
				} else {
					size += count * repetition
				}
				i += count
			}
		}
	}
	return size
}

func part1(input string) string {
	return strconv.Itoa(calculateDecompressedLength(input, 1))
}

func part2(input string) string {
	return strconv.Itoa(calculateDecompressedLength(input, 2))
}

func main() {
	testInput1 := "ADVENT"
	testInput2 := "A(1x5)BC"
	testInput3 := "(3x3)XYZ"
	testInput4 := "A(2x2)BCD(2x2)EFG"
	testInput5 := "(6x1)(1x3)A"
	testInput6 := "X(8x2)(3x3)ABCY"
	testInput7 := "(27x12)(20x12)(13x14)(7x10)(1x12)A"
	testInput8 := "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
	input := utils.ReadFirstLine("09", "input.txt")

	utils.Check("6", part1(testInput1))
	utils.Check("7", part1(testInput2))
	utils.Check("9", part1(testInput3))
	utils.Check("11", part1(testInput4))
	utils.Check("6", part1(testInput5))
	utils.Check("18", part1(testInput6))
	fmt.Printf("Part 1: %s\n", part1(input)) // 97714

	utils.Check("9", part2(testInput3))
	utils.Check("20", part2(testInput6))
	utils.Check("241920", part2(testInput7))
	utils.Check("445", part2(testInput8))
	fmt.Printf("Part 2: %s\n", part2(input)) // 10762972461
}
