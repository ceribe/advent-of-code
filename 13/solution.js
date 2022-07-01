import {check, readInput} from "../Utils.js";

/**
 * Generates all possible permutations of given array
 */
function generatePerms(xs) {
    let ret = []
    for (let i = 0; i < xs.length; i++) {
        let rest = generatePerms(xs.slice(0, i).concat(xs.slice(i + 1)))

        if (!rest.length) {
            ret.push([xs[i]])
        } else {
            for (let j = 0; j < rest.length; j++) {
                ret.push([xs[i]].concat(rest[j]))
            }
        }
    }
    return ret
}

/**
 * Parses the input creating  map of happiness for each person
 */
function getHappinessMap(input) {

    class Info {
        constructor(line) {
            this.who = line[0]
            this.gain = line[3] * (line[2] === "gain" ? 1 : -1)
            this.to = line[10].slice(0, -1)
        }
    }

    const happinessMap = new Map()
    const infos = input.map(value => {
        const tmp = value.split(' ')
        happinessMap.set(tmp[0], new Map())
        return new Info(tmp)
    })
    for (const info of infos) {
        happinessMap.get(info.who).set(info.to, info.gain)
    }
    return happinessMap
}

/**
 * Calculates to maximum possible total happiness from given happinessMap by generating all permutations and checking
 * their total happiness.
 */
function calculateMaxTotalHappiness(happinessMap) {
    const perms = generatePerms([...happinessMap.keys()])
    let maxTotalHappiness = Number.MIN_VALUE
    perms.forEach(perm => {
        const happiness = perm.map((value, index) => {
            const prevIdx = index - 1 < 0 ? perm.length - 1 : index - 1
            const nextIdx = index + 1 === perm.length ? 0 : index + 1
            return happinessMap.get(value).get(perm[prevIdx]) + happinessMap.get(value).get(perm[nextIdx])
        }).sum()
        maxTotalHappiness = Math.max(maxTotalHappiness, happiness)
    })
    return maxTotalHappiness
}

function part1(input) {
    const happinessMap = getHappinessMap(input)
    return calculateMaxTotalHappiness(happinessMap)
}

/**
 * Adds new person to happinessMap with all values equal to 0
 */
function insertMe(happinessMap) {
    const people = [...happinessMap.keys()]
    happinessMap.set("Me", new Map())
    for (const person of people) {
        happinessMap.get(person).set("Me", 0)
        happinessMap.get("Me").set(person, 0)
    }
    return happinessMap
}

function part2(input) {
    const happinessMap = getHappinessMap(input)
    insertMe(happinessMap)
    return calculateMaxTotalHappiness(happinessMap)
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1(testInput), 330)
console.log("Part 1: " + part1(input))

check(part2(testInput), 286)
console.log("Part 2: " + part2(input))