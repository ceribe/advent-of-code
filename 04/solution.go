package main

import (
	utils "advent-of-code-2016"
	"fmt"
	"strconv"
	"strings"
)

func isRoomReal(encryptedName string, checksum string) bool {
	letters := utils.Sort(encryptedName)
	letterMap := make(map[string]int)
	keys := make([]string, 0)
	for len(letters) > 0 {
		letter := string(letters[0])
		count := strings.Count(letters, letter)
		letterMap[letter] = count
		keys = append(keys, letter)
		letters = strings.ReplaceAll(letters, letter, "")
	}
	calculatedChecksum := ""
	for len(calculatedChecksum) < 5 {
		letter := ""
		count := 0
		deletedIdx := 0
		for idx, key := range keys {
			value := letterMap[key]
			if value > count {
				letter = key
				count = value
				deletedIdx = idx
			}
		}
		delete(letterMap, letter)
		keys = append(keys[:deletedIdx], keys[deletedIdx+1:]...)
		calculatedChecksum += letter
	}
	return checksum == calculatedChecksum
}

func part1(input string) string {
	lines := utils.SplitIntoLines(input)
	sum := 0
	for _, line := range lines {
		splitLine := strings.Split(line, "-")
		encryptedName := strings.Join(splitLine[:len(splitLine)-1], "")
		SIDAndChecksum := strings.Split(strings.ReplaceAll(splitLine[len(splitLine)-1], "]", ""), "[")
		SID, _ := strconv.Atoi(SIDAndChecksum[0])
		checksum := SIDAndChecksum[1]
		if isRoomReal(encryptedName, checksum) {
			sum += SID
		}
	}
	return strconv.Itoa(sum)
}

func decrypt(encryptedName string, SID int) string {
	name := strings.ReplaceAll(encryptedName, "-", " ")
	chars := strings.Split(name, "")
	name = ""
	for _, char := range chars {
		newChar := uint8((int(char[0])-97+SID)%26) + 97
		name += string(newChar)
	}
	return name
}

func part2(input string) string {
	lines := utils.SplitIntoLines(input)
	for _, line := range lines {
		splitLine := strings.Split(line, "-")
		encryptedName := strings.Join(splitLine[:len(splitLine)-1], "")
		SIDAndChecksum := strings.Split(strings.ReplaceAll(splitLine[len(splitLine)-1], "]", ""), "[")
		SID, _ := strconv.Atoi(SIDAndChecksum[0])
		checksum := SIDAndChecksum[1]
		if isRoomReal(encryptedName, checksum) {
			decryptedName := decrypt(encryptedName, SID)
			if decryptedName == "northpoleobjectstorage" {
				return strconv.Itoa(SID)
			}
		}
	}
	return ""
}

func main() {
	testInput := utils.ReadInput("04", "test_input.txt")
	input := utils.ReadInput("04", "input.txt")

	utils.Check("1514", part1(testInput))
	fmt.Printf("Part 1: %s\n", part1(input))

	fmt.Printf("Part 2: %s\n", part2(input))
}
