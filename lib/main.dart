
import 'package:first_project/screens/admin/save_cost_breakdown.dart';
import 'package:first_project/screens/admin/savings_cost.dart';
import 'package:first_project/screens/admin/test.dart';
import 'package:first_project/screens/admin/view_savings_cost.dart';
import 'package:first_project/screens/bmi_home.dart';
import 'package:first_project/screens/counter_app.dart';
import 'package:first_project/screens/home_page.dart';
import 'package:first_project/screens/listview_example.dart';
import 'package:flutter/material.dart';
import 'package:first_project/screens/admin/view_meals.dart';


void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => HomePage(), // Define named routes
        '/listview': (context) => ListViewExample(),
        '/addSavings': (context) => AddSavings(),
        '/viewMeals': (context) => ViewMeals(),
        '/addMeals': (context) => Khabar(),
        '/viewSavings': (context) => ViewSavings(),
        '/detailed': (context) => detailed(),
      },
    );
  }
}

