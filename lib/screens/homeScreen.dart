import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/data/data.dart';
import 'package:flutter_expense_tracker/helper.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildCategory(Category category, double totalAmountSpent) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${category.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/\$${category.maxAmount.toStringAsFixed(2)}')
            ],
          ),
          SizedBox(
            height: 12,
          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final double maxBarWidth = constraints.maxWidth;
            final double percent =
                (category.maxAmount - totalAmountSpent) / category.maxAmount;
            double barWidth = percent * maxBarWidth;
            if(barWidth<0){
              barWidth=0;
            }

            return Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6)),
                ),
                Container(
                  width: barWidth,
                  height: 20,
                  decoration: BoxDecoration(
                      color: colorHelper(context, percent),
                      borderRadius: BorderRadius.circular(6)),
                )
              ],
            );
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            pinned: true,
            expandedHeight: 100,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              iconSize: 30,
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Budget Tracker'),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  onPressed: () {})
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: BarChart(weeklySpending),
                );
              } else {
                final category = categories[index - 1];
                double totalAmountSpent = 0;
                category.expenses.forEach((element) {
                  totalAmountSpent += element.cost;
                });
                return _buildCategory(category, totalAmountSpent);
              }
            }, childCount: 1 + categories.length),
          )
        ],
      ),
    );
  }
}
