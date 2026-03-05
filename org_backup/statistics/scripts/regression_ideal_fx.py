import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def quadratic(x, a, b, c):
    return a * x**2 + b * x + c


np.random.seed(42)
x = np.random.uniform(1, 7, 500)
y_true = quadratic(x, 0.2, -1, 1)
y_noisy = y_true + np.random.normal(scale=0.5, size=len(x))
params, _ = curve_fit(quadratic, x, y_noisy)
y_fit = quadratic(np.sort(x), *params)
x1 = 4
y1 = quadratic(x1, *params)  

plt.figure(figsize=(8, 5))
plt.scatter(x, y_noisy, color='gray', alpha=0.4, edgecolors='black')
plt.plot(np.sort(x), y_fit, color='blue', linewidth=2)
plt.axvline(x=x1, color='black', linestyle='-', linewidth=1)
plt.scatter([x1], [y1], color='black', s=100, edgecolors='black')
plt.xlabel("X")
plt.ylabel("Y")
plt.grid(False)

plt.savefig("../pics/regression_ideal_fx.png", dpi=300)

