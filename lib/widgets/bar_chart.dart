import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  BarChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((element) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Weekly spending',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_back,
              size: 24,
            ),
            Text(
              'Nov 11,2019 - Nov 11,2019',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
            Icon(
              Icons.arrow_forward,
              size: 24,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Bar(
                label: 'sa',
                amountSpent: expenses[0],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'su',
                amountSpent: expenses[1],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'mo',
                amountSpent: expenses[2],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'tu',
                amountSpent: expenses[3],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'we',
                amountSpent: expenses[4],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'th',
                amountSpent: expenses[5],
                mostExpensiveValue: mostExpensive),
            Bar(
                label: 'fr',
                amountSpent: expenses[6],
                mostExpensiveValue: mostExpensive),
          ],
        )
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensiveValue;

  Bar({this.label, this.amountSpent, this.mostExpensiveValue});

  final maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    var barHeight = maxBarHeight * (amountSpent / mostExpensiveValue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}'),
        SizedBox(
          height: 6,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.green),
          width: 18,
          height: barHeight,
        ),
        SizedBox(
          height: 8,
        ),
        Text(label)
      ],
    );
  }
}
