
import 'package:first_project/screens/admin/admin_code.dart';
import 'package:first_project/screens/admin/save_cost_breakdown.dart';
import 'package:first_project/screens/admin/savings_cost.dart';
import 'package:first_project/screens/admin/test.dart';
import 'package:first_project/screens/admin/view_savings_cost.dart';
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
      initialRoute: '/detailed', // Set initial route
      routes: {
        '/addSavings': (context) => AddSavings(),
        '/viewMeals': (context) => ViewMeals(),
        '/addMeals': (context) => Khabar(),
        '/viewSavings': (context) => ViewSavings(),
        '/detailed': (context) => detailed(),
        '/admin': (context) => Admin(),
      },
    );
  }
}

