import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

X = np.array([
    [33, 5, 2, 0, 1, 1975, 12],
    [42, 12, 5, 1, 2, 1982, 15],
    [54, 8, 1, 0, 1, 1960, 8],
    [65, 15, 10, 1, 3, 2015, 10],
    [82, 3, 4, 1, 2, 2010, 5],
    [95, 20, 15, 1, 3, 2020, 18],
    [120, 10, 3, 1, 3, 2018, 4],
])
y = np.array([5.2, 6.8, 8.5, 12.1, 15.5, 14.8, 25.0])

model = LinearRegression()
model.fit(X, y)

w1, w2, w3, w4, w5, w6, w7 = model.coef_
intercept = model.intercept_
r_sq = model.score(X, y)

test_data = np.array([
    [70, 7, 5, 1, 3, 2012, 6]
]);
predictions = model.predict(test_data)

print(
    f"Уравнение: y = ({w1:.4f} * площадь) + "
    f"({w2:.4f} * метро) + "
    f"({w3:.4f} * этаж) + "
    f"({w4:.4f} * Балкон) + "
    f"({w5:.4f} * Ремонт) + "
    f"({w6:.4f} * год дома) + "
    f"({w7:.4f} * центр) + "
    f"({intercept:.4f})"
)

print(f"Коэффициент детерминации (R²): {r_sq:.4f}")

print(f"Прогноз для {test_data[0][0]} m2, {test_data[0][0]} метро, {test_data[0][0]} этаж, {test_data[0][0]} Балкон, {test_data[0][0]} Ремонт, {test_data[0][0]} год дома, {test_data[0][0]} центр, цена = {predictions[0]:.2f} млн руб")