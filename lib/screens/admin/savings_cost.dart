import 'dart:convert';

import 'package:first_project/screens/admin/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class AddSavings extends StatefulWidget {
  const AddSavings({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSavings> createState() => _AddSavingsState();
}

class _AddSavingsState extends State<AddSavings> {
  double savings = 0.0;
  double expenses = 0.0;
  String user = 'pranto'; // Add this
  bool isLoading = false;

  Future<Map<String, dynamic>> sendSavingsAndCosts() async {
    try {
      var url =
          Uri.parse('http://127.0.0.1:8000/savings_and_expenses?code=1234');

      // Define data as a Map
      var data = {
        "user": user,
        "savings": double.parse(savings.toString()),
        "expenses": double.parse(expenses.toString()),
        "date": {
          "day": selectedDate.day,
          "month": selectedDate.month,
          "year": selectedDate.year
        }
      };

      // Convert data to JSON format
      var jsonData = jsonEncode(data);

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set content type to JSON
        body: jsonData, // Send JSON data in the request body
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        // Return null or throw an error if desired

        return {'message': 'Error sending data'};
      }
    } catch (error) {
      print('Error sending data: $error');
      // Return null or throw an error if desired
      return {'message': 'Error sending data'};
    }
  }

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
      drawer: drawer(context),
      body: isLoading?Center(
        child: CircularProgressIndicator(),
      ):
        Container(
          color: Colors.green[50],
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
                Text(
                  "user: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ), // Add this
                SizedBox(
                  width: 20,
                ), // Add this
                DropdownButton<String>(
                  // Add this
                  value: user, // Add this
                  items: <String>[
                    'pranto',
                    'saiful',
                    'shakil',
                    'rizve',
                    'milton',
                    'reaz'
                  ].map((String value) {
                    // Add this
                    return DropdownMenuItem<String>(
                      // Add this
                      value: value, // Add this
                      child: Text(value), // Add this
                    ); // Add this
                  }).toList(), // Add this
                  onChanged: (String? newValue) {
                    // Add this
                    if (newValue != null) {
                      setState(() {
                        user = newValue;
                      });
                    }
                  }, // Add this
                ), // Add this
              ],
            ),
            TextField(
              keyboardType: TextInputType.number,
              
              onChanged: (String value) {
                setState(() {
                  if (value.isEmpty)
                  {
                    savings = 0.0;
                  }
                  else{
                  savings = double.parse(value);
                  }
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green[100],
                labelText: 'Enter Savings',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  if (value.isEmpty)
                  {
                    expenses = 0.0;
                  }
                  else{
                  expenses = double.parse(value);
                  }
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.red[100],
                labelText: 'Enter Cost',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                backgroundColor: Colors.blue[400],
              ),
              onPressed: () => _selectDate(context),
              child: Text('Select date', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                backgroundColor: Colors.blue[400],
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                var responseBody =
                    await sendSavingsAndCosts(); // Wait for sendData function to complete
                String message = responseBody['message'];
                bool success = responseBody['success'] ?? false;
                setState(() {
                  isLoading = false;
                });
                showDefaultValuesPopup(context, message, success,
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');

              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
void showDefaultValuesPopup(
  BuildContext context, String message, bool success, String date) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Savings and Cost for the date: $date'),
        content: SingleChildScrollView(
          child: (success ?? false)
              ? ListBody(
                  children: <Widget>[
                    Text('user: $user'),
                    Text('savings: $savings'),
                    Text('expenses: $expenses'),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            message,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green[600],
                          size: 16,
                        )
                      ],
                    )
                  ],
                )
              : ListBody(
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            message,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.red[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.error,
                          color: Colors.red[600],
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                savings = 0.0;
                expenses = 0.0;
                user = 'pranto';
              });
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}