package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

type Node struct {
	x    int
	y    int
	size int
	used int
}

func parseInput(input []string) []Node {
	lines := input[2:]
	nodes := make([]Node, 0)
	for _, line := range lines {
		fields := strings.Fields(line)
		split := strings.Split(fields[0], "-")
		x, _ := strconv.Atoi(split[1][1:])
		y, _ := strconv.Atoi(split[2][1:])
		size, _ := strconv.Atoi(fields[1][:len(fields[1])-1])
		used, _ := strconv.Atoi(fields[2][:len(fields[2])-1])
		nodes = append(nodes, Node{x: x, y: y, size: size, used: used})
	}
	return nodes
}

func part1(input []string) string {
	nodes := parseInput(input)
	count := 0
	for i, iNode := range nodes {
		for j, jNode := range nodes {
			if i == j || iNode.used == 0 {
				continue
			}
			if iNode.used < (jNode.size - jNode.used) {
				count++
			}
		}
	}
	return strconv.Itoa(count)
}

func calc(y int, x int, height int, wallsCount int) int {
	return y + height - x - 1 + (x-(height-wallsCount)+1)*2 + 5*(height-2)
}

func part2(input []string) string {
	nodes := parseInput(input)
	emptyNodeX, emptyNodeY, wallsCount, maxX := 0, 0, 0, 0
	for _, node := range nodes {
		if node.used == 0 {
			emptyNodeX = node.x
			emptyNodeY = node.y
		}
		if node.x > maxX {
			maxX = node.x
		}
		if node.used > 100 {
			wallsCount++
		}
	}
	steps := calc(emptyNodeY, emptyNodeX, maxX+1, wallsCount)
	return strconv.Itoa(steps)
}

func main() {
	input := utils.ReadInput("22", "input.txt")
	fmt.Printf("Part 1: %s\n", part1(input)) // 1024
	fmt.Printf("Part 2: %s\n", part2(input)) // 230
}
