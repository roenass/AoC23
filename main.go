package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	file, err := os.Open("./input.txt")
	if err != nil { log.Fatal(err) }
	defer file.Close()

	var increases int
	latest := 10000000000
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		current, err := strconv.Atoi(scanner.Text())
		fmt.Printf("%d %d\n", latest, current)
		if err != nil { log.Fatal(err) }
		if latest < current { increases++ }
		latest = current
	}
	fmt.Println(increases)
}