package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
)

type State struct {
	elevator   int
	steps      int
	generators []int
	microchips []int
}

/*
If this state is the one in which all generators in microchips are on floor 4
this function returns true
*/
func (state *State) isFinal() bool {
	for _, generator := range state.generators {
		if generator != 4 {
			return false
		}
	}
	for _, microchip := range state.microchips {
		if microchip != 4 {
			return false
		}
	}
	return true
}

/*
Returns hash of this state. Hash is composed of elevator, generators and microchips floor.
*/
func (state *State) hash() int64 {
	hash := int64(0)
	hash += int64(state.elevator)
	hash *= 10
	for _, generator := range state.generators {
		hash += int64(generator)
		hash *= 10
	}
	for _, microchip := range state.microchips {
		hash += int64(microchip)
		hash *= 10
	}
	return hash
}

func (state *State) alreadyVisitedWithLessSteps(stateSet map[int64]int) bool {
	hash := state.hash()
	if stateSet[hash] != 0 && stateSet[hash] <= state.steps {
		return true
	}
	return false
}

func (state *State) markStateAsVisited(stateSet map[int64]int) {
	hash := state.hash()
	if stateSet[hash] > 0 {
		if stateSet[hash] > state.steps {
			stateSet[hash] = state.steps
		}
	} else {
		stateSet[hash] = state.steps
	}
}

/*
Returns floor of given microchip/generator idx.
*/
func (state *State) getFloor(idx int) int {
	if idx >= len(state.generators) {
		return state.microchips[idx-len(state.generators)]
	}
	return state.generators[idx]
}

/*
Sets floor for given microchip/generator idx.
*/
func (state *State) setFloor(idx int, floor int) {
	if idx >= len(state.generators) {
		state.microchips[idx-len(state.generators)] = floor
	} else {
		state.generators[idx] = floor
	}
}

/*
Returns true if state is legal (there is no microchip without a generator on a floor with another generator)
*/
func (state *State) isLegal() bool {
	for i := 0; i < len(state.microchips); i++ {
		if state.microchips[i] == state.generators[i] {
			continue
		}
		for j := 0; j < len(state.generators); j++ {
			if i != j && state.generators[j] == state.microchips[i] {
				return false
			}
		}
	}
	return true
}

func part1(input State) string {
	stateSet := make(map[int64]int)
	minSteps := 999999
	var goToNextStep func(state State)
	goToNextStep = func(state State) {
		state.steps++
		if state.steps > minSteps || state.alreadyVisitedWithLessSteps(stateSet) || !state.isLegal() {
			return
		}
		state.markStateAsVisited(stateSet)
		if state.isFinal() {
			minSteps = utils.Min(state.steps, minSteps)
			return
		}
		//This two loops pick all possible combinations of microchips/generators
		for i := 0; i < len(state.generators)*2; i++ {
			for j := 0; j < len(state.generators)*2; j++ {
				iFloor := state.getFloor(i)
				jFloor := state.getFloor(j)
				//Only move microchips/generators if they are on the same floor as elevator
				if iFloor == state.elevator && iFloor == jFloor {
					move := func(offset int) {
						//Deep copy state
						newState := state
						newState.microchips = append([]int(nil), state.microchips...)
						newState.generators = append([]int(nil), state.generators...)
						newState.elevator += offset
						//Move microchips/generators
						newState.setFloor(i, newState.elevator)
						newState.setFloor(j, newState.elevator)
						//Call recursively on new state
						goToNextStep(newState)
					}
					if state.elevator < 4 {
						move(1)
					}
					//It is pointless to move 2 microchips/generators down at once so only allow to move 1
					if state.elevator > 1 && i == j {
						move(-1)
					}
				}
			}
		}
	}
	goToNextStep(input)
	return strconv.Itoa(minSteps - 1)
}

func part2(input State) string {
	//Add the two new types of microchips and generators
	input.generators = append(input.generators, 1, 1)
	input.microchips = append(input.microchips, 1, 1)
	return part1(input)
}

func main() {
	//Hydrogen, Lithium
	testInput := State{
		elevator:   1,
		generators: []int{2, 3},
		microchips: []int{1, 1},
	}
	//Thulium, Plutonium, Strontium, Promethium, Ruthenium
	input := State{
		elevator:   1,
		generators: []int{1, 1, 1, 3, 3},
		microchips: []int{1, 2, 2, 3, 3},
	}

	utils.Check("11", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))
	fmt.Printf("Part 2: %s\n", part2(input))
}
