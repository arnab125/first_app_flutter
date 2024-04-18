// drawer.dart

import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
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
        // Add more list tiles for other routes
      ],
    ),
  );
}
