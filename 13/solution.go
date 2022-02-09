package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

func isWall(x int, y int, favNumber int) bool {
	sum := x*x + 3*x + 2*x*y + y + y*y + favNumber
	binary := strconv.FormatInt(int64(sum), 2)
	numberOfOnes := strings.Count(binary, "1")
	return numberOfOnes%2 == 1
}

func getWallsMatrix(input int) [][]bool {
	//100x100 map of all positions. true means that position is a wall
	walls := make([][]bool, 100)
	for x := range walls {
		walls[x] = make([]bool, 100)
		for y := range walls[x] {
			walls[x][y] = isWall(x, y, input)
		}
	}
	return walls
}

func getVisitedMatrix() [][]int {
	visited := make([][]int, 100)
	for x := range visited {
		visited[x] = make([]int, 100)
		for y := range visited[x] {
			visited[x][y] = 10000
		}
	}
	return visited
}

func part1(input int, targetX int, targetY int) string {
	minSteps := 99999
	walls := getWallsMatrix(input)
	visited := getVisitedMatrix()
	var move func(x int, y int, steps int)
	move = func(x int, y int, steps int) {
		if steps > minSteps || x < 0 || x > 99 || y < 0 || y > 99 || visited[x][y] <= steps || walls[x][y] {
			return
		}
		if x == targetX && y == targetY {
			minSteps = utils.Min(minSteps, steps)
			return
		}
		steps++
		visited[x][y] = steps
		move(x, y+1, steps)
		move(x+1, y, steps)
		move(x-1, y, steps)
		move(x, y-1, steps)
	}

	move(1, 1, 0)
	return strconv.Itoa(minSteps)
}

func part2(input int) string {
	counter := 0
	walls := getWallsMatrix(input)
	visited := getVisitedMatrix()
	var move func(x int, y int, steps int)
	move = func(x int, y int, steps int) {
		if steps > 50 || x < 0 || x > 99 || y < 0 || y > 99 || visited[x][y] == 1 || walls[x][y] {
			return
		}
		counter++
		steps++
		visited[x][y] = 1
		move(x, y+1, steps)
		move(x+1, y, steps)
		move(x-1, y, steps)
		move(x, y-1, steps)
	}

	//called with -1 steps because entering 1, 1 is counted as a step by recursive function
	move(1, 1, -1)
	return strconv.Itoa(counter)
}

func main() {
	testInput := 10
	input := 1350
	utils.Check("11", part1(testInput, 7, 4))
	fmt.Printf("Part 1: %s\n", part1(input, 31, 39))
	fmt.Printf("Part 2: %s\n", part2(input))
}
