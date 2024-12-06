k=0
for i in range(100000000):
    k+= ((i & 0xFF) << (i & 3))