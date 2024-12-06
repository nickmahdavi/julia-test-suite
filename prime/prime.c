#include <stdio.h>
#include <stdlib.h>

void sieve(const size_t limit) {
    char *primes = calloc(limit + 1, 1);
    if (!primes) return;

    size_t count = limit - 1;
    for (size_t n = 2; n * n <= limit; n++) {
        if (!primes[n]) {
            for (size_t mark = n*n; mark <= limit; mark += n) {
                if (!primes[mark]) {
                    primes[mark] = 1;
                    count--;
                }
            }
        }
    }
    
    printf("Found %zu primes\n", count);
    free(primes);
}

int main(void) {
    sieve(10000000);
}