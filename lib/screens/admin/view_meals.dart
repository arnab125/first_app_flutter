import 'package:flutter/material.dart';

class ViewMeals extends StatelessWidget {
  const ViewMeals({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Meals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Pranto')),
              DataColumn(label: Text('saiful')),
              DataColumn(label: Text('shakil')),
              DataColumn(label: Text('rizve')),
              DataColumn(label: Text('milton')),
              DataColumn(label: Text('reaz')),
              DataColumn(label: Text('Action')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
                
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('2')),
                DataCell(Text('3')),
                DataCell(Text('4')),
                DataCell(Text('5')),
                DataCell(Text('6')),
                DataCell(Text('7')),
                 DataCell(IconButton( // Button in the new column
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle button press
                    // This could navigate to another screen or perform some action
                    print('Delete button pressed');
                  },
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
