int main() {
    long sum = 0;
    for(long i = 0; i < 1000000000; i++) {
        sum += ((i & 0xFF) << (i & 3));
    }
    return 0;
}