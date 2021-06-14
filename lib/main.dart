import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';
import 'package:personal_expense/widgets/transaction_list.dart';
import './models/transaction.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title:TextStyle(
              fontFamily: 'Opensands',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title:TextStyle(
                  fontFamily: 'Opensands',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ) ))
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String? titleInput;
  // String? amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Burger',
    //   amount: 16.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
        Duration(days: 7),
      ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }







  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
        context: ctx,
        builder: (_){

          return GestureDetector(
              child:  NewTransaction(_addNewTransaction),
              onTap: (){},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: [
            IconButton(
              onPressed:()=> _startAddNewTransaction(context),
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions
              ),
              TransactionList(_userTransaction),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),


      ),
    );
  }
}
