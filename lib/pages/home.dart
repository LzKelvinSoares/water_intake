
import 'package:flutter/material.dart';
import 'package:water_intake/components/water_tile.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/model/water_model.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<WaterData>(context, listen: false).getWater();
    super.initState();
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(
      WaterModel(
        amount: double.parse(amountController.text.toString()), 
        dateTime: DateTime.now(), 
        unit: 'ml'
      )
    );

    if (!context.mounted) {
      return;
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
            saveWater();
            Navigator.of(context).pop();
          }, child: Text('Save')),
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => 
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 8.0,
            title: Text('Water'),
            actions: [
              IconButton(onPressed: null, icon: Icon(Icons.map)),          
            ],
          ),
          body: ListView.builder(
            itemCount: value.waterDataList.length,
            itemBuilder: (context, index) {
              final waterModel = value.waterDataList[index];
              return WaterTile(waterModel: waterModel);
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: FloatingActionButton(
            onPressed: addWater,
            child: Icon(Icons.add),
          ),
        ),
    );
  }
}
