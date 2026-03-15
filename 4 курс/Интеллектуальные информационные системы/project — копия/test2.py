import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

X = np.array([
    [33, 5],   # 33м2, 5 мин до метро
    [42, 12],  # 42м2, 12 мин
    [54, 8],   # 54м2, 8 мин
    [65, 15],  # 65м2, 15 мин
    [82, 3],   # 82м2, 3 мин
    [95, 20],  # 95м2, 20 мин
    [120, 10]  # 120м2, 10 мин
])

y = np.array([5.2, 6.8, 8.5, 10.1, 13.0, 14.8, 18.5])

# 2. Создание и обучение модели
model = LinearRegression()
model.fit(X, y)

# 3. Оценка параметров, два коэффициента (w1 для площади, w2 для метро)
w1, w2 = model.coef_
intercept = model.intercept_
r_sq = model.score(X, y)

# 4. Прогноз
# Проверяем для двух квартир:
# 1. 25м2 в 5 минутах от метро
# 2. 75м2 в 15 минутах от метро

test_data = np.array([
    [25, 5],
    [75, 15]
])

predictions = model.predict(test_data)

print(f"Уравнение: y = ({w1:.3f} * площадь) + ({w2:.3f} * метро) + ({intercept:.3f})")
print(f"Коэффициент детерминации (R²): {r_sq:.4f}")

print("-" * 30)
print(f"Прогноз для 25м2, 5 мин до метро: {predictions[0]:.2f} млн руб")
print(f"Прогноз для 75м2, 15 мин до метро: {predictions[1]:.2f} млн руб")