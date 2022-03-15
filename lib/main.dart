import 'package:flutter/material.dart';
import 'package:test_widgets/widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // late String titleInput;
  // late String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter App'),
          ),
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.blue,
                      child: Text(
                        'Chart!',
                      ),
                      elevation: 5,
                    ),
                  ),
                  UserTransactions()
                ],
              ),
            ),
          )
    );
  }
}
