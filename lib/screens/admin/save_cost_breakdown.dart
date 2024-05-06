import 'dart:convert';

import 'package:first_project/screens/admin/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class detailed extends StatefulWidget {
  const detailed({Key? key}) : super(key: key);

  @override
  State<detailed> createState() => _detailedState();
}

class _detailedState extends State<detailed> {
  late Future<Map<String, dynamic>> reportData;

  bool isLoading = false;
  


  @override
  void initState() {
    super.initState();
    reportData = fetchReports();
  }

  Future<Map<String, dynamic>> sendBackup() async {
    try {
      var url = Uri.parse('https://zaformess.azurewebsites.net/send_backup');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        return responseData;
      } else {
        // Return empty map or throw an error if desired
        print('Failed to load meals. Status code: ${response.statusCode}');
        return {};
      }
    } catch (error) {
      print('Error fetching meals data: $error');
      // Return empty map or throw an error if desired
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchReports() async {
    try {
      var url =
          Uri.parse('https://zaformess.azurewebsites.net/full_report');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        return responseData;
      } else {
        // Return empty map or throw an error if desired
        print('Failed to load meals. Status code: ${response.statusCode}');
        return {};
      }
    } catch (error) {
      print('Error fetching meals data: $error');
      // Return empty map or throw an error if desired
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monthly Report',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green[600],
      ),
      drawer: drawer(context),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<Map<String, dynamic>>(
            future: reportData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // Data fetched successfully, now you can use it
                Map<String, dynamic> responseData = snapshot.data!;
                // Example usage of data:
                // double mealRate = responseData['meal_rate'];
                // int totalMeals = responseData['total_meals'][0]['total_meals'];
                // You can access other fields similarly
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(150, 50),
                        foregroundColor: Colors.white, backgroundColor: Colors.green, 
                      ),
                      onPressed:
                            () async {
                              setState(() {
                                isLoading = true;
                              });
                               var responseBody =
                        await sendBackup(); // Wait for sendData function to complete
                                        String message = responseBody['message'] ?? 'Failed to send backup';
                                        bool success = responseBody['success'] ?? false;
                              setState(() {
                                isLoading = false;
                              });
                              showDefaultValuesPopup(context, message, success);
                            },
                            child: isLoading?Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sending Backup...',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              ],
                            )
                            :Text('Send Backup', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    // Other rows and cards go here using data from responseData
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.blue[300],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    'TOTAL SAVING AND EXPENSES',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Savings: ${responseData['total_savings_and_expenses'][0]['total_savings']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Expenses: ${responseData['total_savings_and_expenses'][0]['total_expenses'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Gap: ${responseData['total_savings_and_expenses'][0]['gap'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: responseData[
                                                        'total_savings_and_expenses']
                                                    [0]['gap'] >=
                                                0
                                            ? Colors.green[500]
                                            : Colors.red[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: responseData['give_or_take'][0]['pranto'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Pranto',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['pranto']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['pranto'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['pranto'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['pranto'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['pranto'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: responseData['give_or_take'][0]['saiful'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Saiful',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['saiful']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['saiful'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['saiful'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['saiful'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['saiful'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Card(
                          color: responseData['give_or_take'][0]['shakil'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Shakil',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['shakil']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['shakil'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['shakil'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['shakil'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['shakil'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: responseData['give_or_take'][0]['milton'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Milton',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['milton']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['milton'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['milton'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['milton'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['milton'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: responseData['give_or_take'][0]['rizve'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Rizve',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['rizve']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['rizve'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['rizve'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['rizve'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['rizve'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: responseData['give_or_take'][0]['reaz'] >= 0
                              ? Colors.green[500]
                              : Colors.red[400],
                          child: SizedBox(
                            width: screenWidth - 20,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Reaz',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Consumed: ${responseData['meals_per_person'][0]['reaz']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Total Meals: ${responseData['total_meals'][0]['total_meals']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Rate: ${responseData['meal_rate']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Savings: ${responseData['individual_savings'][0]['reaz'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Expense: ${responseData['individual_expenses'][0]['reaz'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Meal Cost: ${responseData['individual_meal_cost'][0]['reaz'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Transactions: ${responseData['give_or_take'][0]['reaz'] ?? 0}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
  void showDefaultValuesPopup(BuildContext context, String message, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Status'),
        content: SingleChildScrollView(
          child: (success??false)?ListBody(
            children: <Widget>[
              Row(
                children: [
                  Text(message, style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold),),
                  Icon(Icons.check, color: Colors.green[600], size: 16,)
                ],
              )
            ],
          ):
          ListBody(
            children: <Widget>[
              Row(
                children: [
                  Text(message, style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold),),
                  Icon(Icons.error, color: Colors.red[600], size: 16,)
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}
