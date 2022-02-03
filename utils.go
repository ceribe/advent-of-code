package advent_of_code_2016

import (
	"io/ioutil"
	"log"
)

func ReadInput(dayNumber string, fileName string) string {
	content, err := ioutil.ReadFile(dayNumber + "/" + fileName)
	if err != nil {
		log.Fatal(err)
	}
	return string(content)
}

func Check(expected string, value string) {
	if expected != value {
		log.Fatal("Expected", expected, "got", value)
	}
}
