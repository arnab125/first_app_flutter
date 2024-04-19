import 'dart:convert';

import 'package:first_project/screens/admin/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewMeals extends StatefulWidget {
  const ViewMeals({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewMeals> createState() => _ViewMealsState();
}

class _ViewMealsState extends State<ViewMeals> {
  bool isLoading = false;
  bool okButtonClicked = false;

  late Future<List<Map<String, dynamic>>> mealsData;

  @override
  void initState() {
    super.initState();
    mealsData = fetchMeals();
  }

  Future<List<Map<String, dynamic>>> fetchMeals() async {
    try {
      var url = Uri.parse('http://127.0.0.1:8000/get_meals?code=1234');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> mealsList = responseData['meals'];
        List<Map<String, dynamic>> mealsData = mealsList.cast<Map<String, dynamic>>();
        return mealsData;
      } else {
        // Return empty list or throw an error if desired
        print('Failed to load meals. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching meals data: $error');
      // Return empty list or throw an error if desired
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteMeal(String id) async {
    try {
      var url = Uri.parse('http://127.0.0.1:8000/delete_meal?code=1234&id=$id');

      var response = await http.get(url);

      if (response.statusCode == 200) {

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody;

    }  else {
        // Return empty list or throw an error if desired
        print('Failed to load meals. Status code: ${response.statusCode}');
        return {};
      }
    } catch (error) {
      print('Error fetching meals data: $error');
      // Return empty list or throw an error if desired
      return {};
    }
  }

  

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
    drawer: drawer(context),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: okButtonClicked ? fetchMeals() : mealsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> meals = snapshot.data!;
          return isLoading?Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text('Deleting meal... Please wait...', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
              ],
            ),
          ):SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Pranto')),
                  DataColumn(label: Text('Saiful')),
                  DataColumn(label: Text('Shakil')),
                  DataColumn(label: Text('Milton')),
                  DataColumn(label: Text('Rizve')),
                  DataColumn(label: Text('Reaz')),
                  DataColumn(label: Text('Action')),
                ],
                rows: meals.map((meal) {
                  return DataRow(cells: [
                    DataCell(Text('${meal['date']['day']}/${meal['date']['month']}/${meal['date']['year']}')),
                    DataCell(Text('${meal['pranto']}')),
                    DataCell(Text('${meal['saiful']}')),
                    DataCell(Text('${meal['shakil']}')),
                    DataCell(Text('${meal['milton']}')),
                    DataCell(Text('${meal['rizve']}')),
                    DataCell(Text('${meal['reaz']}')),
                    DataCell(
                      IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        setState(() {
                      isLoading = true;
                    });
                    var responseBody = await deleteMeal(meal['_id']);
                    String message = responseBody['message'];
                   bool success = responseBody['success'] ?? false;
                    setState(() {
                      isLoading = false;
                    });
                   
                    showDefaultValuesPopup(context, message, success, '${meal['date']['day']}/${meal['date']['month']}/${meal['date']['year']}');
                                    },
                    
                    )),
                  ]);
                }).toList(),
              ),
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
        title: Text('Meals for the date: $date'),
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
