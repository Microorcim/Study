import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

X = np.array([
    [1, 2, 1, 0, 1],
    [3, 3, 2, 1, 2],
    [5, 4, 3, 1, 0],
    [2, 2, 1, 1, 4],
    [10, 5, 3, 1, 1],
    [7, 4, 2, 0, 2]
])
y = np.array([1.2, 2.5, 4.0, 2.1, 7.5, 4.8])

model = LinearRegression()
model.fit(X, y)

w1, w2, w3, w4, w5 = model.coef_
intercept = model.intercept_
r_sq = model.score(X, y)

test_data = np.array([
    [4, 3, 2, 1, 3]
]);
predictions = model.predict(test_data)

print(
    f" Параметры "
    f"({w1:.4f} * опыт) + "
    f"({w2:.4f} * Стек) + "
    f"({w3:.4f} * Формат) + "
    f"({w4:.4f} * Англиский) + "
    f"({w5:.4f} * Курсы) + "
)

print(f"Зп = {predictions[0]:.4f} Зарплата в год")