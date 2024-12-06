function sieve(n)
    primes = fill(true, n)
    primes[1] = false
    
    for i in 2:isqrt(n)
        if primes[i]
            for j in (i*i):i:n
                primes[j] = false
            end
        end
    end
    
    count = sum(primes)
    println("Found $count primes")
end

sieve(10_000_000)