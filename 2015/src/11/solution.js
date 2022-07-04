import { check } from "../utils.js";

function increase(password) {
  password[password.length - 1] = password.last() + 1;
  for (let i = password.length - 2; i >= 0; i--) {
    if (password[i + 1] !== 123) break;
    password[i + 1] = 97;
    password[i] = password[i] + 1;
  }
  return password;
}

/**
 * Iterates through password and checks if any three numbers are increasing straight
 */
function hasOneStraightIncreasingTriple(password) {
  for (let i = 0; i < password.length - 2; i++) {
    if (
      password[i] + 2 === password[i + 2] &&
      password[i + 2] === password[i + 1] + 1
    ) {
      return true;
    }
  }
  return false;
}

/**
 * Tests if password contains any illegal letter using regex
 */
const containsIllegalLetters = (password) =>
  /[iol]/.test(String.fromCharCode(...password));

/**
 * Converts password to string then divides it into sequences of same letters ( "aabccc" => ["aa", "b", "ccc"].
 * Those sequences are then filtered and then checked if there are at least two sequences left or if there is a
 * sequence of length 4 or more (two pairs back to back)
 */
function hasTwoPairs(password) {
  const letters = String.fromCharCode(...password)
    .match(/(.)\1*/g)
    .filter((value) => value.length >= 2);
  return (
    letters.length >= 2 ||
    letters.filter((value) => value.length >= 4).length > 1
  );
}

function part1and2(input) {
  let password = input.split("").map((value) => value.charCodeAt(0));
  password = increase(password);
  while (
    !(
      hasOneStraightIncreasingTriple(password) &&
      !containsIllegalLetters(password) &&
      hasTwoPairs(password)
    )
  ) {
    password = increase(password);
  }
  return String.fromCharCode(...password);
}

const input = "cqjxjnds";

check("abcdffaa", part1and2("abcdefgh"));
check("ghjaabcc", part1and2("ghijklmn"));
console.log("Part 1: " + part1and2(input)); // cqjxxyzz
console.log("Part 2: " + part1and2(part1and2(input))); // cqkaabcc
