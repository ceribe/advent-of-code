package main

import (
	utils "2016/src"
	"fmt"
)

func createData(data []bool, size int, currentSize int) {
	for i := currentSize - 1; i >= 0; i-- {
		if 2*currentSize-i >= size {
			return
		}
		if !data[i] {
			data[2*currentSize-i] = true
		}
	}
	createData(data, size, currentSize*2+1)
}

func calculateChecksum(data []bool, currentSize int) int {
	if currentSize%2 == 1 {
		return currentSize
	}
	for i := 0; i < currentSize; i += 2 {
		if data[i] == data[i+1] {
			data[i/2] = true
		} else {
			data[i/2] = false
		}
	}
	return calculateChecksum(data, currentSize/2)
}

func part1and2(input string, diskSize int) string {
	//Convert input string to a slice
	data := make([]bool, diskSize)
	for i := 0; i < len(input); i++ {
		if string(input[i]) == "1" {
			data[i] = true
		}
	}

	//Apply algorithm to create data and calculate checksum
	createData(data, diskSize, len(input))
	checksumSize := calculateChecksum(data, len(data))

	//Convert checksum slice to a string
	checksumString := ""
	for i := 0; i < checksumSize; i++ {
		if data[i] {
			checksumString += "1"
		} else {
			checksumString += "0"
		}
	}
	return checksumString
}

func main() {
	testInput := "10000"
	input := "01110110101001000"

	utils.Check("01100", part1and2(testInput, 20))
	fmt.Printf("Part 1: %s\n", part1and2(input, 272))      // 11100111011101111
	fmt.Printf("Part 2: %s\n", part1and2(input, 35651584)) // 10001110010000110
}
