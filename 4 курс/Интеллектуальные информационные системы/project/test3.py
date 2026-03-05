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

# Несколько графиков: по оси X — цена, по Y — признак; линия — предсказание модели
y_pred = model.predict(X)
feature_names = ['Площадь, м2', 'Метро, мин', 'Этаж', 'Балкон', 'Ремонт', 'Год дома', 'Центр, км']
coef = model.coef_

fig, axes = plt.subplots(2, 4, figsize=(14, 8))
axes = axes.flatten()

for i in range(7):
    ax = axes[i]
    # Точки: X = цена, Y = признак
    ax.scatter(y, X[:, i], color='blue', s=50, label='Факт (обучение)', zorder=3)
    ax.scatter(y_pred, X[:, i], color='orange', s=50, marker='^', label='Прогноз (обучение)', zorder=3)
    ax.scatter(predictions[0], test_data[0, i], color='red', s=100, marker='*', label='Тестовая точка', zorder=4)
    # Кривая модели: при фиксированных средних остальных признаках price = w_i * x_i + C_i => x_i = (price - C_i) / w_i
    C_i = intercept + sum(coef[j] * X[:, j].mean() for j in range(7) if j != i)
    price_range = np.linspace(y.min(), max(y.max(), y_pred.max()), 100)
    if abs(coef[i]) > 1e-10:
        feature_curve = (price_range - C_i) / coef[i]
        ax.plot(price_range, feature_curve, 'g-', linewidth=2, label='Предсказание модели')
    ax.set_xlabel('Цена, млн руб')
    ax.set_ylabel(feature_names[i])
    ax.set_title(feature_names[i])
    ax.legend(fontsize=7)
    ax.grid(True, alpha=0.3)

# 8-й график: общая зависимость — по X предсказание по всем 7 признакам, по Y цена (факт)
ax = axes[7]
ax.scatter(y_pred, y, color='blue', s=50, label='Обучение: прогноз vs факт', zorder=3)
ax.scatter(predictions[0], predictions[0], color='red', s=100, marker='*', label='Тестовая точка', zorder=4)
p_min, p_max = min(y.min(), y_pred.min()), max(y.max(), y_pred.max())
ax.plot([p_min, p_max], [p_min, p_max], 'g-', linewidth=2, label='Идеал (прогноз = факт)')
ax.set_xlabel('Предсказанная цена (все 7 признаков), млн руб')
ax.set_ylabel('Фактическая цена, млн руб')
ax.set_title('Все признаки сразу')
ax.legend(fontsize=7)
ax.grid(True, alpha=0.3)

plt.suptitle('Признак от цены: факт и прогноз', fontsize=12)
plt.tight_layout()
plt.show()
