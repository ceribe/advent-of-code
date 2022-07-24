package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"github.com/nickdavies/go-astar/astar"
	"strconv"
	"strings"
)

func part1and2(input string, maxNumber int, returnToStart bool) string {
	//Map of the shortest paths between each number
	//e.g. paths[0][4] would be the shortest path between 0 and 4
	paths := make([][]int, maxNumber+1)
	for i := range paths {
		paths[i] = make([]int, maxNumber+1)
	}
	paths = calculatePaths(paths, input)
	shortestDistance := findShortestDistance(paths, returnToStart)
	return strconv.Itoa(shortestDistance)
}

/*
Populates given paths matrix with the shortest distances between each pair of points using A*
*/
func calculatePaths(paths [][]int, input string) [][]int {
	lines := utils.SplitIntoLines(input)
	y := len(lines)
	x := len(lines[0])
	a := astar.NewAStar(y, x)
	p2p := astar.NewPointToPoint()
	pointsPos := make([][]astar.Point, len(paths))

	for i, line := range lines {
		for j, char := range line {
			if char == '#' {
				a.FillTile(astar.Point{Row: i, Col: j}, -1)
			} else if char == '.' {
				continue
			} else {
				pointsPos[int(char-'0')] = []astar.Point{{Row: i, Col: j}}
			}
		}
	}

	for i := 0; i < len(paths); i++ {
		for j := i; j < len(paths); j++ {
			path := a.FindPath(p2p, pointsPos[i], pointsPos[j])
			paths[i][j] = path.DistTraveled
			paths[j][i] = path.DistTraveled
		}
	}
	return paths
}

/*
Returns distance of the shortest path which goes through all points at least once
*/
func findShortestDistance(paths [][]int, returnToStart bool) int {
	currMin := 99999
	var solveTSP func(path string, curr int)
	solveTSP = func(path string, curr int) {
		if len(path) == len(paths) {
			if returnToStart {
				lastNode, _ := strconv.Atoi(path[len(path)-1:])
				curr = curr + paths[lastNode][0]
			}
			if currMin > curr {
				currMin = curr
			}
			return
		}
		for i := 0; i < len(paths); i++ {
			prevNode, _ := strconv.Atoi(path[len(path)-1:])
			currNode := string(rune('0' + i))
			if strings.Count(path, currNode) == 0 {
				solveTSP(path+currNode, curr+paths[prevNode][i])
			}
		}
	}
	solveTSP("0", 0)
	return currMin
}

func main() {
	testInput := utils.ReadInput("24", "test_input.txt")
	input := utils.ReadInput("24", "input.txt")

	utils.Check("14", part1and2(testInput, 4, false))
	fmt.Printf("Part 1: %s\n", part1and2(input, 7, false))
	fmt.Printf("Part 2: %s\n", part1and2(input, 7, true))
}
