#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>

#define SIZE_MAX    256

char grid[SIZE_MAX][SIZE_MAX];

bool is_special(char c) {
    return !(isdigit(c) || c == '.' || c == '\n');
}

int main (void)
{
    int linenum=0, sum=0, i, x, y;

    for(x=0; x<SIZE_MAX; x++)
        for(y=0; y<SIZE_MAX; y++)
            grid[x][y]='.';
    while(fgets(grid[linenum++], SIZE_MAX, stdin)) {}

    for(i=0; i<linenum; i++) {
        int j=0;
//        if(i>0) {printf("%i: %s", i-1, grid[i-1]);}
//        printf("%i: %s", i, grid[i]);
 //       printf("%i: %s", i+1, grid[i+1]);
        for(j=0; j<SIZE_MAX && grid[i][j] && grid[i][j] != '\n'; j++) {
            int k, number=0;
            for(k=j; isdigit(grid[i][k]); k++) {
//                printf("%i/%i (%s): %c\n", i, k, isdigit(grid[i][k])?"digit":"other", grid[i][k]);
                if(k==j) {
                    number=grid[i][k]-'0';
                }
                if(k>j) {
                    number=10*number+grid[i][k]-'0';
                }
            }
            if(number>0) {
                int left = j>0?j-1:j;
                int rite = k, ln, l;
                bool valid=false;
                for(ln = i>0?i-1:i; ln<linenum && ln<=i+1 && !valid; ln++) {
//                    printf("line %i: %s\n", ln, grid[ln]);
                    for(l=left; l<=rite && !valid; l++) {
                        if(is_special(grid[ln][l])) {
                            valid=true;
                        }
                    }
                }
                if(valid) {
//                    printf("valid number: %i on line %i of %i\n", number, ln, linenum);
                    sum+=number;
//                    printf("boundaries for %i on %i: %i..%i\n", number, i, left, rite);
                } else {
//                    printf("invalid number: %i\n", number);
                }
            }
            j=k;
        }
    }
    printf("Sum of part numbers: %i\n", sum);
    return 0;
}