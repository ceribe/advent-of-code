import {check, readInput} from "../Utils.js";

class Ingredient {
    constructor(line) {
        line = line.replaceAll(',', '').split(' ')
        this.capacity = parseInt(line[2])
        this.durability = parseInt(line[4])
        this.flavor = parseInt(line[6])
        this.texture = parseInt(line[8])
        this.calories = parseInt(line[10])
    }
}

function part1and2(input) {
    const ingredients = input.map(line => new Ingredient(line))
    let currMax = Number.MIN_VALUE
    let currMaxWith500Calories = Number.MIN_VALUE

    function getScore(quantities) {
        let capacity = 0
        let durability = 0
        let flavor = 0
        let texture = 0
        let calories = 0
        for (let i = 0; i < quantities.length; i++) {
            capacity += ingredients[i].capacity * quantities[i]
            durability += ingredients[i].durability * quantities[i]
            flavor += ingredients[i].flavor * quantities[i]
            texture += ingredients[i].texture * quantities[i]
            calories += ingredients[i].calories * quantities[i]
        }
        return [Math.max(0, capacity) * Math.max(0, durability) * Math.max(0, flavor) * Math.max(0, texture), calories]
    }

    function go(quantities, totalAmount) {
        if (quantities.length === ingredients.length) {
            const [score, calories] = getScore(quantities)
            currMax = Math.max(currMax, score)
            if (calories === 500) {
                currMaxWith500Calories = Math.max(currMaxWith500Calories, score)
            }
            return
        }
        for (let i = 0; i <= 100 - totalAmount; i++) {
            go(quantities.concat([i]), totalAmount + i)
        }
    }

    go([], 0)
    return [currMax, currMaxWith500Calories]
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

const testScores = part1and2(testInput)
const scores = part1and2(input)

check(testScores[0], 62842880)
console.log("Part 1: " + scores[0])

check(testScores[1], 57600000)
console.log("Part 2: " + scores[1])