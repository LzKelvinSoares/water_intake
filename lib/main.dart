import 'package:flutter/material.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>  WaterData(),
      child: MaterialApp(
        title: 'Water Intake',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
        ),
        home: const HomePage(),
      ),
    );
  }
}
