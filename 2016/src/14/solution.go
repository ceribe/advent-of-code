package main

import (
	utils "2016/src"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func part1and2(input string, part2 bool) string {
	hashes := make(map[int]string)
	counter := 0

	getHash := func(index int) string {
		if hashes[index] == "" {
			hash := utils.Hash(input + strconv.Itoa(index))
			if part2 {
				for i := 0; i < 2016; i++ {
					hash = utils.Hash(hash)
				}
			}
			hashes[index] = hash
		}
		return hashes[index]
	}

	isValid := func(hash string, index int) bool {
		//Go's regex does not have back-references, so I'm stuck with this monstrosity
		re := regexp.MustCompile(`(1{3}|2{3}|3{3}|4{3}|5{3}|6{3}|7{3}|8{3}|9{3}|0{3}|a{3}|b{3}|c{3}|d{3}|e{3}|f{3})`)
		res := re.Find([]byte(hash))
		if res != nil {
			sequence := strings.Repeat(string(res[0]), 5)
			for i := index + 1; i < index+1001; i++ {
				if strings.Contains(getHash(i), sequence) {
					return true
				}
			}
		}
		return false
	}

	index := 0
	for counter < 64 {
		hash := getHash(index)
		if isValid(hash, index) {
			counter++
		}
		index++
	}
	return strconv.Itoa(index - 1)
}

func main() {
	testInput := "abc"
	input := "cuanljph"

	utils.Check("22728", part1and2(testInput, false))
	fmt.Printf("Part 1: %s\n", part1and2(input, false)) // 23769

	utils.Check("22551", part1and2(testInput, true))
	fmt.Printf("Part 2: %s\n", part1and2(input, true)) // 20606
}
