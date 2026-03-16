import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import StandardScaler

X = np.array([
    [5, 3, 1000, 0, 0],
    [20, 15, 5000, 10, 1],
    [10, 5, 2500, 5, 0],
    [40, 30, 10000, 20, 1],
    [2, 1, 500, 0, 0],
])

y = np.array([1200, 8500, 3100, 22000, 0])

scaler = StandardScaler()
Xscaled = scaler.fit_transform(X)

model = LinearRegression()
model.fit(Xscaled, y)

w1, w2, w3, w4, w5 = model.coef_
intercept = model.intercept_
r_sq = model.score(X, y)

test_data = np.array([
    [15, 10, 3000, 7, 1]
])

scalerTestData = scaler.transform(test_data)
predictions = model.predict(scalerTestData)

print(
    f"Время = {w1:.2f}"
    f"Товары = {w2:.2f}"
    f"Цена = {w3:.2f}"
    f"Скидка = {w4:.2f}"
    f"Лояльность = {w5:.2f}"
    f"intercept = {intercept:.2f}"
)

print(f"Коэф детерминации (R2) = {r_sq}")

print(f"Прогноз для Время {test_data[0][0]} Товары {test_data[0][1]} Цена {test_data[0][2]} Скидка {test_data[0][3]} Лояльность {test_data[0][4]}")
print(f"Ожидаемая покупка = {predictions[0]:.4f}")