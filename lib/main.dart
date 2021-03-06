
import 'package:flutter/material.dart';
import 'package:test_widgets/widgets/new_transaction.dart';
import 'package:test_widgets/widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late String titleInput;
  //final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    /*

    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())

     */
  ];

  List<Transaction> get _recentTransacations {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personnal expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return MaterialApp(
        title: 'Personnal expenses',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        home: Scaffold(
          appBar: appBar,

          /*

          AppBar(
            title: Text(
              'Personnal expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          ),

          */
          body: SingleChildScrollView(
            //MediaQuery methods in use
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /*

                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.purple,
                    child: Text(
                      'Chart!',
                    ),
                    elevation: 5,
                  ),
                ),

                 */
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(this._recentTransacations)),
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction)),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _startAddNewTransaction(context),
            child: Icon(
              Icons.add,
            ),
          ),
        ));
  }
}
