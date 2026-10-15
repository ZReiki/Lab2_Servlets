<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Лабораторна робота №2 - Servlets</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h1>Завдання 1. Наближене обчислення за рядом Тейлора</h1>
        </div>

        <hr>

        <div class="task-requirments">
            <p>Для заданих <i>x, n, e</i>, що вводяться через форму:</p>
            <ol type="a">
                <li>Обчислити суму n доданків згідно з варіантом;</li>
                <li>Обчислити суму тих доданків, які за абсолютним
                    значенням більше <i>e</i>. (Завдання виконати для
                    двох різних <i>e</i>, які відрізняються на порядок,
                    для кожного випадку обчислити кількість доданків);
                </li>
                <li>
                    Порівняти результати з "точним" значенням відповідної
                    функції (сума визначає наближене значення) для <i>х Є (-R, R)</i>.
                </li>
            </ol>

            <p><strong>Варіант 18</strong></p>

            <div class="formula-box">
                <math>
                    <mrow>
                        <mo>sin</mo><mo>(</mo><mi>x</mi><mo>)</mo><mo>=</mo><mi>x</mi><mo>-</mo>
                        <mfrac>
                            <mrow><msup><mi>x</mi><mn>3</mn></msup></mrow>
                            <mrow><mn>3</mn><mo>!</mo></mrow>
                        </mfrac>
                        <mo>+</mo>
                        <mfrac>
                            <mrow><msup><mi>x</mi><mn>5</mn></msup></mrow>
                            <mrow><mn>5</mn><mo>!</mo></mrow>
                        </mfrac>
                        <mo>-</mo>
                        <mfrac>
                            <mrow><msup><mi>x</mi><mn>7</mn></msup></mrow>
                            <mrow><mn>7</mn><mo>!</mo></mrow>
                        </mfrac>
                        <mo>+</mo><mtext>...</mtext><mo>(</mo><mi>R</mi><mo>=</mo><mi>∞</mi><mo>)</mo>
                    </mrow>
                </math>
            </div>
        </div>

        <div class="task-inputs">
            <form method="post" action="${pageContext.request.contextPath}/numerical-sequence">
                <label>Значення Х:
                    <input type="number" name="value_x" alt="Значення змінної х!" placeholder="Введіть значення змінної X"
                    value="${sessionScope.value_x != null ? sessionScope.value_x : '1.0'}" step="any"/>
                </label>
                <label>Значення N:
                    <input type="number" name="value_n" title="Значення змінної n!" placeholder="Введіть значення змінної N"
                    value="${sessionScope.value_n != null ? sessionScope.value_n : '10'}"/>
                </label>
                <label>Значення E1:
                    <input type="number" name="value_e1" title="Значення змінної e!" placeholder="Введіть значення змінної E1"
                    value="${sessionScope.value_e1 != null ? sessionScope.value_e1 : '0.000001'}" step="any"/>
                </label>
                <label>Значення E2:
                    <input type="number" name="value_e2" title="Значення змінної e!" placeholder="Введіть значення змінної E2"
                    value="${sessionScope.value_e2 != null ? sessionScope.value_e2 : '0.0000001'}" step="any"/>
                </label>
                <button type="submit">Обчислити</button>
            </form>
        </div>

        <c:if test="${not empty sequenceResult}">
            <div class="results-box">
                <h3>Результати обчислень:</h3>
                <table class="result-table">
                    <thead>
                        <tr>
                            <th>Параметр / Метод</th>
                            <th>Отримане значення</th>
                            <th>Кількість доданків</th>
                            <th>Похибка від sin(x)</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>Сума n доданків</td>
                            <td>${sequenceResult.sumN()}</td>
                            <td>${sessionScope.value_n}</td>
                            <td>${sequenceResult.errorN()}</td>
                        </tr>
                        <tr>
                            <td>За точністю e₁ (${sessionScope.value_e1})</td>
                            <td>${sequenceResult.sumE1().sum()}</td>
                            <td>${sequenceResult.sumE1().count()}</td>
                            <td>${sequenceResult.errorE1()}</td>
                        </tr>
                        <tr>
                            <td>За точністю e₂ (${sessionScope.value_e2})</td>
                            <td>${sequenceResult.sumE2().sum()}</td>
                            <td>${sequenceResult.sumE2().count()}</td>
                            <td>${sequenceResult.errorE2()}</td>
                        </tr>
                        <tr style="font-weight: bold; background-color: #f1f5f9;">
                            <td>Точне Math.sin(x)</td>
                            <td colspan="3">${sequenceResult.exact()}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <hr>

    <div class="card">
        <div class="card-header">
            <h1>Завдання 2. Табулювання та графік функції</h1>
        </div>
        <div class="task-requests">
            <p>
                Виконати табулювання функції <i>f(x)</i> на відрізку [a; b] з кроком h.<br>
                За результатом табулювання побудувати графік функції. Значення <i>a, b, h</i> вводяться через форму та
                передаються на сервер як параметри запиту.
            </p>

            <p>Варіант 18</p>

            <div class="formula-box">
                <math>
                    <mrow>
                        <mi>y</mi><mo>=</mo>
                        <msup>
                            <mi>e</mi>
                            <mrow>
                                <mo>ln</mo><mo>(</mo><mi>x</mi><mo>)</mo><mo>-</mo><mn>1</mn>
                            </mrow>
                        </msup>
                        <mo>+</mo><mo>sin</mo><mo>(</mo><mi>x</mi><mo>)</mo>
                    </mrow>
                </math>
            </div>
        </div>

        <div class="task-inputs">
            <form method="post" action="${pageContext.request.contextPath}/tabulation">
                <label>Початок інтервалу (a):
                    <input type="number" name="value_a" title="Значення змінної a!" placeholder="Введіть значення змінної a!"
                    value="${sessionScope.value_a != null ? sessionScope.value_a : '1.0'}" step="any"/>
                </label>
                <label>Кінець інтервалу (b):
                    <input type="number" name="value_b" title="Значення змінної b!" placeholder="Введіть значення змінної b!"
                           value="${sessionScope.value_b != null ? sessionScope.value_b : '2.0'}" step="any"/>
                </label>
                <label>Крок (h):
                    <input type="number" name="value_h" title="Значення змінної h!" placeholder="Введіть значення змінної h!"
                           value="${sessionScope.value_h != null ? sessionScope.value_h : '0.01'}" step="any"/>
                </label>
                <button type="submit">Побудувати графік</button>
            </form>
        </div>

        <c:if test="${not empty points}">
            <div class="graphic-container">
                <canvas id="functionChart"></canvas>
            </div>

            <script>
                const points = [
                    <c:forEach var="p" items="${points}" varStatus="status">
                    { x: ${p.x()}, y: ${p.y()} }${status.last ? '' : ','}
                    </c:forEach>
                ];

                new Chart(document.getElementById('functionChart'), {
                    type: 'line',
                    data: {
                        datasets: [{
                            label: 'f(x)',
                            data: points,
                            parsing: false,
                            borderColor: '#4f46e5',
                            backgroundColor: '#4f46e5',
                            pointRadius: 0,
                            borderWidth: 2,
                            tension: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                type: 'linear',
                                title: {
                                    display: true,
                                    text: 'x'
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'f(x)'
                                }
                            }
                        }
                    }
                });
            </script>
        </c:if>
    </div>

</div>
</body>
</html>