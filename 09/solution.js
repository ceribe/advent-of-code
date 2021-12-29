import {check, readInput} from "../Utils.js";

function parseInput(input) {
    const map = new Map()
    function addToMap(from, to, cost) {
        if (map.has(from)) {
            map.get(from).push([to, cost])
        }
        else {
            map.set(from, [[to, cost]])
        }
    }
    input.map(line => line.split(" ")).forEach(line => {
        const from = line[0]
        const to = line[2]
        const cost = parseInt(line[4])
        addToMap(from, to, cost)
        addToMap(to, from, cost)
    })
    return map
}

function part1(input) {
    const map = parseInput(input)
    let minCost = Number.MAX_VALUE
    function go(visited, cost) {
        if (minCost < cost)
            return
        if (visited.length === map.size) {
            minCost = cost
            return
        }
        const nextCities = map.get(visited.last())
        if (typeof nextCities === 'undefined')
            return
        nextCities.forEach(city => {
            if (!visited.includes(city[0])) {
                go(visited.concat([city[0]]), cost + city[1])
            }
        })
    }
    map.forEach((_, key) => {
        go([key], 0)
    })
    return minCost
}

function part2(input) {
    const map = parseInput(input)
    let maxCost = Number.MIN_VALUE
    function go(visited, cost) {
        if (visited.length === map.size && maxCost < cost) {
            maxCost = cost
            return
        }
        const nextCities = map.get(visited.last())
        if (typeof nextCities === 'undefined')
            return
        nextCities.forEach(city => {
            if (!visited.includes(city[0])) {
                go(visited.concat([city[0]]), cost + city[1])
            }
        })
    }
    map.forEach((_, key) => {
        go([key], 0)
    })
    return maxCost
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1(testInput), 605)
console.log("Part 1: " + part1(input))

check(part2(testInput), 982)
console.log("Part 2: " + part2(input))