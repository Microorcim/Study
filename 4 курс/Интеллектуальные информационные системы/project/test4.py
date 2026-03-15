import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

ratings = [
    [5, 4, 3, 2],
    [4, 5, 2, 2],
    [3, 2, 5, 4]
]

weights = [0.5, 0.3, 0.2]

FilmNames = ["Фильм1", "Фильм2", "Фильм3", "Фильм4"]

result = np.dot(weights, ratings)
print(result)

sorted_result = sorted(
    zip(FilmNames, result), 
    key=lambda x: x[1], 
    reverse=True
)
#print(sorted_result)

for n, s in sorted_result:
    print(f"{n}: {s:.2f}")