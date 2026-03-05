import numpy as np
from sklearn.linear_model import LinearRegression

#Данные
X = np.array([33, 42, 54, 65, 82, 95, 120]).reshape(-1,1)
y = np.array([5.2, 6.8, 8.5, 10.1, 13.0, 14.8, 18.5])

# создание и обучение модели
model = LinearRegression()
model.fit(X, y)

# Оценка параметров
slope = model.coef_[0]
intercept = model.intercept_
r_sq = model.score(X,y)

#  Прогноз
test_data = np.array([[25], [75]])
predictions = model.predict(test_data)
print(f"Уравнение: y = {slope:.3f}x + {intercept:.3f}")
print(f"Коэффициент детерминации (R2): {r_sq:.4f}")
print(f"Прогноз для 25 м²: {predictions[0]:.2f} млн")
print(f"Прогноз для 75 м²: {predictions[1]:.2f} млн")

