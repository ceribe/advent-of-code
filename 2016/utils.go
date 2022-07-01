package advent_of_code_2016

import (
	"crypto/md5"
	"encoding/hex"
	"io/ioutil"
	"log"
	"sort"
	"strings"
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
		log.Fatal("Expected ", expected, " got ", value+"\n")
	}
}

func Min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func Max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func Sort(w string) string {
	s := strings.Split(w, "")
	sort.Strings(s)
	return strings.Join(s, "")
}

func SplitIntoLines(text string) []string {
	return strings.Split(strings.ReplaceAll(text, "\r\n", "\n"), "\n")
}

func Hash(data string) string {
	h := md5.Sum([]byte(data))
	return hex.EncodeToString(h[:])
}
