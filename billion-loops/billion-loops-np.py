"""    
k=0
for i in range(100000000):
    k+= ((i & 0xFF) << (i & 3))
"""
import numpy as np

i = np.arange(100_000_000)
((i & 0xFF) << (i & 3)).sum()