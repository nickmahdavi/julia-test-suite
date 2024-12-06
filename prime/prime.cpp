#include <iostream>
#include <vector>

void sieve(const size_t limit) {
    std::vector<char> primes(limit + 1);

    size_t count = limit - 1;
    for (size_t n = 2; n * n <= limit; n++) {
        if (!primes[n]) {
            for (size_t mark = n * n; mark <= limit; mark += n) {
                if (!primes[mark]) {
                    primes[mark] = 1;
                    count--;
                }
            }
        }
    }
    
    std::cout << "Found " << count << " primes\n";
}

int main() {
    sieve(10000000);
}