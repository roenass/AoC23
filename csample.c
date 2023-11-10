#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

#define len 256


int main(int argc, char **argv) {
    int max=0, maxelf=0;
    int elf=1, count=0;
    char line[len];

    while (fgets(line,len,stdin)) {
        // printf("%i: (%lu) %i %s", elf, strlen(line), line[0], line);
        if(line[0] == '\n') {
            if(count>max) {
                maxelf=elf;
                max=count;
            }
            elf++;
            count=0;
        } else {
            count+= (int)strtol(line, (char **)NULL, 10);
        }
    }
    printf("Elf %i carries %i calories\n", elf, max);
}