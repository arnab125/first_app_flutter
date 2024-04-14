import 'package:flutter/material.dart';

class AddSavings extends StatefulWidget {
  const AddSavings({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSavings> createState() => _AddSavingsState();
}

class _AddSavingsState extends State<AddSavings> {

  double savings = 0.0;
  double cost = 0.0;
  String user = 'pranto'; // Add this
  
  Map<String, String> dictionary = {};

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Savings and Cost',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add Savings and Cost',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("user: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), // Add this
                SizedBox(width: 20,), // Add this
                DropdownButton<String>( // Add this
                  value: user, // Add this
                  items: <String>['pranto', 'saiful', 'shakil', 'rizve', 'milton', 'reaz'].map((String value) { // Add this
                    return DropdownMenuItem<String>( // Add this
                      value: value, // Add this
                      child: new Text(value), // Add this
                    ); // Add this
                  }).toList(), // Add this
                  onChanged: (_) {
                    setState(() {
                      user = _!;
                    });
                  }, // Add this
                ), // Add this
            ],),
            TextField(
              onChanged: (String value) {
                setState(() {
                  savings = double.parse(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter Savings',
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  cost = double.parse(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter Cost',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
           ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              SizedBox(
                height: 20,
              ),
            ElevatedButton(
              onPressed: () {
                dictionary['user'] = user;
                dictionary['savings'] = savings.toString();
                dictionary['cost'] = cost.toString();
                dictionary['date'] = selectedDate.toString();
                print(dictionary);
              },
              child: Text('Add'),
            ),
          SizedBox(
            height: 20,
          ),
          ],
        ),
      ),
    );
  }
}
