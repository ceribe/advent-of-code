package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

type Range struct {
	max  uint32
	min  uint32
	sign int
}

func parseInput(input string) []Range {
	ranges := make([]Range, 0)
	lines := utils.SplitIntoLines(input)
	for _, line := range lines {
		split := strings.Split(line, "-")
		min, _ := strconv.ParseInt(split[0], 10, 64)
		max, _ := strconv.ParseInt(split[1], 10, 64)
		ranges = append(ranges, Range{min: uint32(min), max: uint32(max), sign: 1})
	}
	return ranges
}

func part1(input string) string {
	ranges := parseInput(input)
	smallest := uint32(0)
LOOP:
	for true {
		for _, r := range ranges {
			if smallest <= r.max && smallest >= r.min {
				smallest = r.max + 1
				continue LOOP
			}
		}
		break
	}
	return strconv.Itoa(int(smallest))
}

func minUInt32(a, b uint32) uint32 {
	if a < b {
		return a
	}
	return b
}

func maxUInt32(a, b uint32) uint32 {
	if a > b {
		return a
	}
	return b
}

func part2(input string, maxIP int64) string {
	ranges := parseInput(input)
	mergedRanges := make([]Range, 0)
	for _, r := range ranges {
		intersections := make([]Range, 0)
		for _, mergedRange := range mergedRanges {
			if mergedRange.min > r.max || r.min > mergedRange.max {
				continue
			}
			min := maxUInt32(r.min, mergedRange.min)
			max := minUInt32(r.max, mergedRange.max)
			sign := 1
			if mergedRange.sign == 1 {
				sign = -1
			}
			intersections = append(intersections, Range{min: min, max: max, sign: sign})
		}
		mergedRanges = append(mergedRanges, r)
		mergedRanges = append(mergedRanges, intersections...)
	}
	totalBlacklisted := int64(0)
	for _, r := range mergedRanges {
		totalBlacklisted += int64(r.max-r.min+1) * int64(r.sign)
	}
	return strconv.Itoa(int(maxIP - totalBlacklisted + 1))
}

func main() {
	testInput := utils.ReadInput("20", "test_input.txt")
	input := utils.ReadInput("20", "input.txt")

	utils.Check("3", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))
	utils.Check("2", part2(testInput, 9))
	fmt.Printf("Part 2: %s\n", part2(input, 4294967295))
}
