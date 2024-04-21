// drawer.dart

import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 25)),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        
        ListTile(
          title: Text('View Meals'),
          onTap: () {
            Navigator.pushNamed(context, '/viewMeals');
          },
        ),
        ListTile(
          title: Text('Add Meals'),
          onTap: () {
            Navigator.pushNamed(context, '/addMeals');
          },
        ),
        ListTile(
          title: Text('Add Savings and Expenses'),
          onTap: () {
            Navigator.pushNamed(context, '/addSavings');
          },
        ),
        ListTile(
          title: Text('View Savings and Expenses'),
          onTap: () {
            Navigator.pushNamed(context, '/viewSavings');
          },
        ),
        ListTile(
          title: Text('Monthly Report'),
          onTap: () {
            Navigator.pushNamed(context, '/detailed');
          },
        ),
        ListTile(
          title: Text('Admin'),
          onTap: () {
            Navigator.pushNamed(context, '/admin');
          },
        ),
        // Add more list tiles for other routes
      ],
    ),
  );
}
