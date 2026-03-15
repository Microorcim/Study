# Библиотеки: numpy — работа с массивами
import numpy as np
import matplotlib.pyplot as plt
# sklearn — модель линейной регрессии
from sklearn.linear_model import LinearRegression

# --- Исходные данные ---
# X — признак (например, площадь в м2), 
#       reshape(-1,1) даёт столбец — так требует sklearn
X = np.array([33, 42, 54, 65, 82, 95, 120]).reshape(-1,1)
# y — целевая переменная (значение, которое предсказываем)
y = np.array([5.2, 6.8, 8.5, 10.1, 13.0, 14.8, 18.5])

# --- Обучение модели ---
# Создаём объект модели линейной регрессии (ищем прямую y = k*x + b)
model = LinearRegression()
# fit подбирает коэффициенты k и b по методу наименьших квадратов по данным X и y
model.fit(X, y)

# --- Параметры обученной модели ---
# slope (угловой коэффициент k) — насколько меняется y при увеличении x на 1
slope = model.coef_[0]
# intercept (свободный член b) — значение y при x = 0
intercept = model.intercept_
# R² — доля объяснённой дисперсии: от 0 до 1, чем ближе к 1, тем лучше модель описывает данные
r_sq = model.score(X,y)

# --- Прогноз для новых значений ---
# Задаём точки, для которых хотим получить предсказание (тем же форматом — столбец)
test_data = np.array([[25], [75]])
# predict возвращает предсказанные значения y по обученной прямой
predictions = model.predict(test_data)
print(f"Уравнение: y = {slope:.3f}x + {intercept:.3f}")
print(f"Коэффициент детерминации (R2): {r_sq:.4f}")
print(f"Прогноз для 25 м2: {predictions[0]:.2f} млн")
print(f"Прогноз для 75 м2: {predictions[1]:.2f} млн")

# График: точки данных и линия регрессии
x_line = np.linspace(X.min(), X.max(), 100).reshape(-1, 1)
y_line = model.predict(x_line)

plt.figure(figsize=(8, 5))
plt.scatter(X, y, color='blue', s=60, label='Исходные данные', zorder=3)
plt.plot(x_line, y_line, color='red', linewidth=2, label=f'Линия регрессии: y = {slope:.3f}x + {intercept:.3f}')
plt.scatter(test_data, predictions, color='green', s=80, marker='s', label='Прогнозы (25 и 75 м2)', zorder=3)
plt.xlabel('Площадь, м2')
plt.ylabel('Значение, млн')
plt.title('Линейная регрессия')
plt.legend()
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
