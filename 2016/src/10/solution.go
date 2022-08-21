package main

import (
	utils "2016/src"
	"fmt"
	"strconv"
	"strings"
)

type Bot struct {
	chip1   int
	chip2   int
	bot1    int
	bot2    int
	output1 int
	output2 int
}

func initBots(input []string) []Bot {
	numberOfBots := 210
	bots := make([]Bot, numberOfBots)
	for _, line := range input {
		split := strings.Split(line, " ")
		if split[0] == "value" {
			value, _ := strconv.Atoi(split[1])
			botIdx, _ := strconv.Atoi(split[5])
			giveChip(&bots[botIdx], value)
		} else {
			botIdx, _ := strconv.Atoi(split[1])

			if split[5] == "bot" {
				lowBotIdx, _ := strconv.Atoi(split[6])
				bots[botIdx].bot1 = lowBotIdx
			} else {
				bots[botIdx].bot1 = -1
				lowOutputIdx, _ := strconv.Atoi(split[6])
				bots[botIdx].output1 = lowOutputIdx
			}

			if split[10] == "bot" {
				highBotIdx, _ := strconv.Atoi(split[11])
				bots[botIdx].bot2 = highBotIdx
			} else {
				bots[botIdx].bot2 = -1
				highOutputIdx, _ := strconv.Atoi(split[6])
				bots[botIdx].output2 = highOutputIdx
			}
		}
	}
	return bots
}

func giveChip(bot *Bot, chip int) {
	if bot.chip1 == 0 {
		bot.chip1 = chip
	} else {
		bot.chip2 = chip
	}
}

func part1(input []string) string {
	bots := initBots(input)
	for true {
		for idx, bot := range bots {
			if bot.chip1 != 0 && bot.chip2 != 0 {
				if (bot.chip1 == 61 || bot.chip1 == 17) && (bot.chip2 == 61 || bot.chip2 == 17) {
					return strconv.Itoa(idx)
				}
				lowerChip := utils.Min(bot.chip1, bot.chip2)
				higherChip := utils.Max(bot.chip1, bot.chip2)
				bots[idx].chip1 = 0
				bots[idx].chip2 = 0
				if bot.bot1 != -1 {
					giveChip(&bots[bot.bot1], lowerChip)
				}
				if bot.bot2 != -1 {
					giveChip(&bots[bot.bot2], higherChip)
				}
				break
			}
		}
	}
	return ""
}

func part2(input []string) string {
	bots := initBots(input)
	numberOfOutputs := 21
	outputs := make([]int, numberOfOutputs)
LOOP:
	for true {
		for idx, bot := range bots {
			if bot.chip1 == 0 || bot.chip2 == 0 {
				continue
			}
			lowerChip := utils.Min(bot.chip1, bot.chip2)
			higherChip := utils.Max(bot.chip1, bot.chip2)
			bots[idx].chip1 = 0
			bots[idx].chip2 = 0
			if bot.bot1 != -1 {
				giveChip(&bots[bot.bot1], lowerChip)
			} else {
				outputs[bot.output1] = lowerChip
			}
			if bot.bot2 != -1 {
				giveChip(&bots[bot.bot2], higherChip)
			} else {
				outputs[bot.output2] = higherChip
			}
			continue LOOP
		}
		break
	}
	product := outputs[0] * outputs[1] * outputs[2]
	return strconv.Itoa(product)
}

func main() {
	input := utils.ReadInput("10", "input.txt")
	fmt.Printf("Part 1: %s\n", part1(input)) // 101
	fmt.Printf("Part 2: %s\n", part2(input)) // 37789
}
