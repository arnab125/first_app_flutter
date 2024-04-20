import 'dart:convert';

import 'package:first_project/screens/admin/drawer.dart';
import 'package:first_project/screens/admin/get_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewSavings extends StatefulWidget {
  const ViewSavings({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewSavings> createState() => _ViewSavingsState();
}

class _ViewSavingsState extends State<ViewSavings> {
  bool isLoading = false;
  bool okButtonClicked = false;

  late Future<List<Map<String, dynamic>>> savingsData;

  @override
  void initState() {
    super.initState();
    savingsData = fetchSavings();
  }

  Future<List<Map<String, dynamic>>> fetchSavings() async {
    try {
      var url = Uri.parse('https://advanced-teddie-pranto.koyeb.app/get_savings_and_expenses');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> savingsList = responseData['savings_and_expenses'];
        List<Map<String, dynamic>> savingsData = savingsList.cast<Map<String, dynamic>>();
        return savingsData;
      } else {
        // Return empty list or throw an error if desired
        print('Failed to load savings. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching savings data: $error');
      // Return empty list or throw an error if desired
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteSaving(String id) async {
    try {
      String? code = await getSecretCode();
      var url = Uri.parse('https://advanced-teddie-pranto.koyeb.app/delete_savings_and_expense?code=$code&id=$id');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        // Return empty list or throw an error if desired
        print('Failed to load savings. Status code: ${response.statusCode}');
        return {};
      }
    } catch (error) {
      print('Error fetching savings data: $error');
      // Return empty list or throw an error if desired
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Savings and Expenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      drawer: drawer(context),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: okButtonClicked ? fetchSavings() : savingsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Map<String, dynamic>> savings = snapshot.data!;
            return isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text(
                          'Deleting savings... Please wait...',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: savings.map((saving) {
                        return Card(
                          child: ListTile(
                            title: Text('${saving['date']['day']}/${saving['date']['month']}/${saving['date']['year']}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            ), // ${saving['date']}/${saving['month']}/${saving['year'
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${saving['user']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
                                Text('Saving: ${saving['savings']}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                Text('Expense: ${saving['expenses']}', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Map<String, dynamic> response = await deleteSaving(saving['_id']);
                                setState(() {
                                  isLoading = false;
                                });
                                showDefaultValuesPopup(context, response['message'], response['success'],
                                    '${saving['date']['day']}/${saving['date']['month']}/${saving['date']['year']}');
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
          }
        },
      ),
    );
  }

  void showDefaultValuesPopup(BuildContext context, String message, bool success, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('savings for the date: $date'),
          content: SingleChildScrollView(
            child: (success ?? false)
                ? ListBody(
                    children: <Widget>[
                      Row(
                        children: [Flexible(
                          child: Text(
                            message,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                  okButtonClicked = true;
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
