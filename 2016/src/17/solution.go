package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

type State struct {
	x    int
	y    int
	path string
}

func isOpen(char string) bool {
	openChars := "bcdef"
	return strings.Contains(openChars, char)
}

func (state *State) getLegalDirections(passcode string) (dirs string) {
	hash := utils.Hash(passcode + state.path)[:4]

	if isOpen(hash[0:1]) && state.y > 0 {
		dirs += "U"
	}
	if isOpen(hash[1:2]) && state.y < 3 {
		dirs += "D"
	}
	if isOpen(hash[2:3]) && state.x > 0 {
		dirs += "L"
	}
	if isOpen(hash[3:4]) && state.x < 3 {
		dirs += "R"
	}
	return
}

func addNextStatesToQueue(queue chan State, currState State, passcode string) {
	legalDirections := currState.getLegalDirections(passcode)
	if strings.Contains(legalDirections, "U") {
		queue <- State{x: currState.x, y: currState.y - 1, path: currState.path + "U"}
	}
	if strings.Contains(legalDirections, "D") {
		queue <- State{x: currState.x, y: currState.y + 1, path: currState.path + "D"}
	}
	if strings.Contains(legalDirections, "L") {
		queue <- State{x: currState.x - 1, y: currState.y, path: currState.path + "L"}
	}
	if strings.Contains(legalDirections, "R") {
		queue <- State{x: currState.x + 1, y: currState.y, path: currState.path + "R"}
	}
}

func part1(input string) string {
	queue := make(chan State, 2048)
	initialState := State{x: 0, y: 0, path: ""}
	queue <- initialState
	for true {
		currState := <-queue
		if currState.x == 3 && currState.y == 3 {
			return currState.path
		}
		addNextStatesToQueue(queue, currState, input)
	}
	return ""
}

func part2(input string) string {
	//Here queue is not really needed and this could be solved by recursion as searching for the longest path does not require BFS
	queue := make(chan State, 2048)
	initialState := State{x: 0, y: 0, path: ""}
	maxLength := 0
	queue <- initialState
	for len(queue) > 0 {
		currState := <-queue
		if currState.x == 3 && currState.y == 3 {
			maxLength = utils.Max(maxLength, len(currState.path))
			continue
		}
		addNextStatesToQueue(queue, currState, input)
	}
	return strconv.Itoa(maxLength)
}

func main() {
	testInput1 := "ihgpwlah"
	testInput2 := "kglvqrro"
	testInput3 := "ulqzkmiv"
	input := "qzthpkfp"

	utils.Check("DDRRRD", part1(testInput1))
	utils.Check("DDUDRLRRUDRD", part1(testInput2))
	utils.Check("DRURDRUDDLLDLUURRDULRLDUUDDDRR", part1(testInput3))
	fmt.Printf("Part 1: %s\n", part1(input)) // RDDRLDRURD

	utils.Check("370", part2(testInput1))
	utils.Check("492", part2(testInput2))
	utils.Check("830", part2(testInput3))
	fmt.Printf("Part 2: %s\n", part2(input)) // 448
}
