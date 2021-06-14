import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {


  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack() ,
        ),
        SizedBox( height: 4,),
        Text(label),
      ],
    );
  }
}
