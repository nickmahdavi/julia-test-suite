import time

def sieve(n):
    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False
    
    for i in range(2, int(n**0.5) + 1):
        if is_prime[i]:
            for j in range(i*i, n + 1, i):
                is_prime[j] = False
            
    count = sum(1 for x in is_prime if x)
    print(f"Found {count} primes")

n = 10_000_000
sieve(n)