import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();
  void saveWater(String amount) async {
    final url = Uri.https('water-intaker-42b34-default-rtdb.firebaseio.com', 'water.json');

    var response = await http.post(
      url, 
      headers: { 
        'Content-type': 'application/json'
      }, 
      body: json.encode({
        'amount': double.parse(amount),
        'unit': 'ml',
        'dateTime': DateTime.now().toString()
      })
    );

    if (response.statusCode == 200) {
      print('Data Saved');
    } else {
      print('Data Not Saved');
    }
  }

  void addWater() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Add water'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add water to your daily intake'),
            SizedBox(height: 10,),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount'
              ),
            ),
            // TextField()
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text('Cancel')
          ),
          TextButton(onPressed: () {
            // Save here
            saveWater(amountController.text);
          }, child: Text('Save')),
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8.0,
        title: Text('Water'),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.map)),          
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: addWater,
        child: Icon(Icons.add),
      ),
    );
  }
}
